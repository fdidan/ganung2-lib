import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final rememberMe = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    final savedEmail = box.read('email');
    final savedPassword = box.read('password');
    final savedRemember = box.read('rememberMe') ?? false;

    if(savedRemember) {
      emailController.text = savedEmail ?? '';
      passwordController.text = savedPassword ?? '';
      rememberMe.value = true;
    }
  }

  bool onSuccess(){
    if(Auth().currentUser != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty){
      Get.snackbar('Error', 'Email dan Kata sandi wajib diisi!');
      return;
    }
    try {
      isLoading.value = true;
      await Auth().login(email: email, password: password);
      isLoading.value = false;

      if(rememberMe.value) {
        box.write('email', email);
        box.write('password', password);
        box.write('rememberMe', true);
      }else{
        box.remove('email');
        box.remove('password');
        box.write('rememberMe', false);
      }

      if(onSuccess()){
        Get.snackbar('Berhasil', 'Selamat datang!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite, overlayColor: kWhite,);
        Get.offAllNamed('/navigation');
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Gagal', e.message ?? 'Terjadi kesalahan.', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite, overlayColor: kWhite,);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await Auth().signInWithGoogle().then(
          (value) async => await Get.offAllNamed('/navigation')
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Gagal', e.message ?? 'Terjadi kesalahan.', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite, overlayColor: kWhite,);
    }
  }
}