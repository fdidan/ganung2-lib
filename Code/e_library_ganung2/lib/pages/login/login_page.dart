import 'package:e_library_ganung2/pages/login/login_controller.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final controller = Get.put(LoginController());

  bool passInvisible = false;

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.sizeOf(context).width;
    var heightDevice = MediaQuery.sizeOf(context).height;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: widthDevice * 0.1),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: heightDevice * 0.15,
            ),
            SizedBox(
              width: widthDevice * 0.8,
              child: Text(
                'Masuk sekarang!',
                style: kHeading1,
              ),
            ),
            SizedBox(
              width: widthDevice * 0.8,
              child: Text(
                'Selamat datang kembali! Ayo masuk dan kita lanjutkan petualangan!',
                style: kBodyItalic,
              ),
            ),
            SizedBox(height: heightDevice * 0.05),
            Text(
              'Alamat Email',
              style: kLabelField,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border(
                      top: BorderSide(color: kDeepSeaBlue, width: 2),
                      bottom: BorderSide(color: kDeepSeaBlue, width: 2),
                      right: BorderSide(color: kDeepSeaBlue, width: 2),
                      left: BorderSide(color: kDeepSeaBlue, width: 2))),
              height: 42,
              child: TextFormField(
                controller: controller.emailController,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: InputBorder.none,
                  fillColor: kWhiteCool,
                ),
              ),
            ),
            SizedBox(
              height: heightDevice * 0.03,
            ),
            Text(
              'Kata Sandi',
              style: kLabelField,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border(
                      top: BorderSide(color: kDeepSeaBlue, width: 2),
                      bottom: BorderSide(color: kDeepSeaBlue, width: 2),
                      right: BorderSide(color: kDeepSeaBlue, width: 2),
                      left: BorderSide(color: kDeepSeaBlue, width: 2))),
              height: 42,
              child: TextFormField(
                controller: controller.passwordController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    border: InputBorder.none,
                    fillColor: kWhiteCool,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passInvisible = !passInvisible;
                          });
                        },
                        icon: Icon(passInvisible
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: !passInvisible,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(height: 20, width: 20,
                  child: Checkbox(
                    checkColor: kWhite,
                      activeColor: kDeepSeaBlue,
                      value: controller.rememberMe.value,
                      onChanged: (value){
                        setState(() {
                          controller.rememberMe.value = value!;
                        });
                      }
                  ),
                ),
                SizedBox(width: 12,),
                Text('Ingat saya', style: kKredit2,)
              ],
            ),
            SizedBox(
              height: heightDevice * 0.03,
            ),
            Center(
              child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null :  () {
                    controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDeepSeaBlue,
                      minimumSize: Size(widthDevice * 0.5, 46),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Text(
                    'Masuk',
                    style: kTextButton,
                  )
              )),
            ),
            SizedBox(
              height: heightDevice * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 130,
                  height: 1,
                  color: kDarkGrey,
                ),
                Text(
                  'Atau',
                  style: kBodyNormal,
                ),
                Container(
                  width: 130,
                  height: 1,
                  color: kDarkGrey,
                ),
              ],
            ),
            SizedBox(
              height: heightDevice * 0.05,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  controller.signInWithGoogle();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/google_logo.png'),
                  backgroundColor: kWhite,
                ),
              ),
            ),
            SizedBox(
              height: heightDevice * 0.05,
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kamu baru bergabung? ',
                  style: kBodyNormal,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Daftar di sini!',
                    style: kLabelField,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
