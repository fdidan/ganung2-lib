import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/book_model.dart';

class RecommendationController extends GetxController {
  final recommendedBooks = <Book>[].obs;
  final isLoading = false.obs;

  Future<void> fetchRecommendations(String bookId) async {
    final url = Uri.parse('https://845a19978438.ngrok-free.app/recommend');

    final body = json.encode({
      'book_id': bookId,
      'top_k': 5,
    });

    try {
      isLoading.value = true;

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        recommendedBooks.value = jsonList.map((json) => Book.fromJson(json)).toList();
      } else {
        print('Gagal fetch rekomendasi: ${response.statusCode} - ${response.body}');
        recommendedBooks.clear();
      }
    } catch (e) {
      print('Error fetch rekomendasi: $e');
      recommendedBooks.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
