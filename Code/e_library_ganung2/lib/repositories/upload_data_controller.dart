import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UploadBooksController extends GetxController {
  Future<void> uploadBooksFromJson() async {
    try {
      // 1. Baca file JSON dari assets
      final String jsonString = await rootBundle.loadString('assets/random_books.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);

      // 2. Upload setiap entri ke koleksi 'books'
      for (final book in jsonList) {
        final docId = book['id'];

        await FirebaseFirestore.instance.collection('books').doc(docId).set({
          'title': book['title'],
          'author': book['author'],
          'description': book['description'],
          'genre': List<String>.from(book['genre']),
          'cover_link': book['cover_link'],
        });
      }

      Get.snackbar("Berhasil", "Semua buku berhasil diunggah ke Firestore!");
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan saat mengunggah: $e");
    }
  }
}
