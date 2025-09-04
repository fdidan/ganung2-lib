import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/book_model.dart';

class BookController extends GetxController {
  final books = <Book>[].obs;
  final newBooks = <Book>[].obs;
  final oldBooks = <Book>[].obs;
  final randomBooks = <Book>[].obs;
  final RxString searchQuery = ''.obs;
  final storage = GetStorage();
  final cacheKey = 'cachedBook';
  final timeKey = 'lastFetchTime';
  final cacheDuration = Duration(hours: 12);

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final lastFetchTimeString = storage.read(timeKey);
    final now = DateTime.now();

    if(lastFetchTimeString != null){
      final lastFetchTime = DateTime.parse(lastFetchTimeString);
      final isCacheValid = now.difference(lastFetchTime) < cacheDuration;

      if(isCacheValid){
        final cachedData = storage.read(cacheKey);
        if(cachedData!=null){
          books.assignAll(
            List<Map<String, dynamic>>.from(cachedData)
                .map((data) => Book.fromMap(data))
                .toList(),
          );
          return loadBooksFromCached();
        }
      }
    }

    try{
      final snapshot = await FirebaseFirestore
          .instance
          .collection('books')
          .limit(2000).get();

      final fetchBooks = snapshot.docs.map((doc){
        return Book.fromFirestore(doc.id, doc.data());
      }).toList();

      books.assignAll(fetchBooks);

      final jsonList = fetchBooks.map((b) => b.toMap()).toList();
      await storage.write(cacheKey, jsonList);
      await storage.write(timeKey, now.toIso8601String());

      // Kategori
      newBooks.value = books.take(10).toList(); // Belum ada tanggal, pakai sementara
      oldBooks.value = books.reversed.take(10).toList();
      randomBooks.value = [...books]..shuffle();
      randomBooks.value = randomBooks.take(10).toList();
    }catch (e){
      Get.snackbar('Gagal', 'Gagal memuat buku! $e');
    }
  }

  Future<void> forceRefresh() async{
    await storage.remove(cacheKey);
    await storage.remove(timeKey);
    await loadBooks();
  }

  List<Book> get filteredBooks {
    if (searchQuery.isEmpty) {
      return books;
    } else {
      return books
          .where((book) =>
      book.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          book.author.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<String> get suggestions {
    final q = searchQuery.value.toLowerCase();
    return books
        .map((b) => b.title)
        .where((title) => title.toLowerCase().contains(q))
        .toSet()
        .toList();
  }

  Future<void> loadBooksFromCached() async {
    try {
      final loadedBooks = books;

      // Kategori
      newBooks.value = loadedBooks.take(10).toList(); // Belum ada tanggal, pakai sementara
      oldBooks.value = loadedBooks.reversed.take(10).toList();
      randomBooks.value = [...loadedBooks]..shuffle();
      randomBooks.value = randomBooks.take(10).toList();
    } catch (e) {
      Get.snackbar('Gagal', "Gagal memuat. Sedang memuat ulang.");

    }
  }

  Future<void> updateUserBookInteraction({
    required String userId,
    required String bookId,
    String status = 'belum',
  }) async {
    final docId = '${userId}_$bookId';
    final docRef = FirebaseFirestore.instance.collection('user_books').doc(docId);

    final doc = await docRef.get();
    final now = DateTime.now();

    if (doc.exists) {
      // Update status jika berubah
      await docRef.update({
        'status': status,
        'lastInteraction': now,
        'updatedAt': now,
      });
    } else {
      // Buat baru
      await docRef.set({
        'userId': userId,
        'bookId': bookId,
        'status': status,
        'lastInteraction': now,
        'updatedAt': now,
      });
    }
  }

}
