import 'dart:convert';
import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/book_model.dart';

class PersonalizedRecommendationController extends GetxController {
  final recommendedBooks = <Book>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final uid = Auth().currentUser?.uid;
  final String baseUrl = 'https://845a19978438.ngrok-free.app';

  @override
  onInit(){
    super.onInit();
    fetchPersonalizedRecommendations(uid!);
  }

  Future<void> fetchPersonalizedRecommendations(String uid, {int topK = 10}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/personalized_recommendation?uid=$uid&top_k=$topK'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        recommendedBooks.value = data.map((e) => Book.fromJson(e)).toList();
      } else {
        errorMessage.value = jsonDecode(response.body)['error'] ?? 'Unknown error';
        recommendedBooks.clear();
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      recommendedBooks.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
