import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../style/color.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  final isLoading = false.obs;

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPassController.text;

    if (email.isEmpty || password.isEmpty || confirm.isEmpty){
      Get.snackbar('Error', 'Semua formulir wajib diisi!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kDeepSeaBlue, overlayColor: kDeepSeaBlue,);
    }else{
      if(password == confirm) {
        try {
          isLoading.value = true;
          await Auth().register(email: email, password: password);
          isLoading.value = false;

          Get.snackbar('Berhasil', 'Selamat datang!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kDeepSeaBlue, overlayColor: kDeepSeaBlue,);
          Get.offAllNamed('/navigation');
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          Get.snackbar('Login Gagal', e.message ?? 'Terjadi kesalahan.', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kDeepSeaBlue, overlayColor: kDeepSeaBlue,);
        }
      }else{
        Get.snackbar('Error', 'Konfirmasi kata sandi harus sama dengan Kata sandi!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kDeepSeaBlue, overlayColor: kDeepSeaBlue,);
      }
    }
  }
}