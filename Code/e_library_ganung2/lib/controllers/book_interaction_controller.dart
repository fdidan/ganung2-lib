import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_library_ganung2/model/book_model.dart';
import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BookInteractionController extends GetxController {
  final status = ''.obs;
  final db = FirebaseDatabase.instance.ref();
  final firestore = FirebaseFirestore.instance;
  final uid = Auth().currentUser?.uid;

  // Status yang digunakan di UI tab
  final List<String> statuses = ['Tandai', 'Sedang', 'Selesai'];

  // Map status → daftar buku
  final booksByStatus = <String, List<Book>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooksByStatus();
  }

  Future<void> fetchBooksByStatus() async {
    if (uid == null) {
      return;
    }

    final ref = db.child('interactions/$uid');

    try {
      final snapshot = await ref.get();
      final data = snapshot.value;
      if (data == null) {
        booksByStatus.assignAll({for (var s in statuses) s: []});
        return;
      }

      final rawMap = Map<String, dynamic>.from(data as Map);

      Map<String, List<Book>> tempMap = {
        for (var s in statuses) s: [],
      };

      for (final entry in rawMap.entries) {
        final bookId = entry.key;
        final value = entry.value;

        if (value is Map && value['status'] != null) {
          final status = _capitalize(value['status']);
          if (statuses.contains(status)) {
            final doc = await FirebaseFirestore.instance
                .collection('books')
                .doc(bookId)
                .get();
            if (doc.exists && doc.data() != null) {
              final book = Book.fromFirestore(doc.id, doc.data()!);
              tempMap[status]!.add(book);
            } else {
            }
          }
        }
      }

      booksByStatus.assignAll(tempMap);
      update();
    } catch (e, st) {
      Get.snackbar('Error', 'Gagal memuat : $e. $st');
    }
  }

  String _capitalize(String input) {
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }


  Future<void> loadStatus(String bookId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      try {
        final snapshot = await db.child('interactions/$uid/$bookId').get();
        if (snapshot.exists) {
          final data = snapshot.value as Map;
          status.value = data['status'] ?? '';
        } else {
          status.value = '';
        }
      } catch (e) {
        Get.snackbar('Error', 'e.');
      }
    } else {
      return;
    }
  }

  Future<void> setStatus(String bookId, String newStatus) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        return;
      }

      final ref = db.child('interactions/$uid/$bookId');
      await ref.set({
        'status': newStatus,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      status.value = newStatus;
      await fetchBooksByStatus();
    } catch (e, stacktrace) {
      Get.snackbar('Error', '$e. $stacktrace');
    }

    await fetchBooksByStatus();
  }
}
