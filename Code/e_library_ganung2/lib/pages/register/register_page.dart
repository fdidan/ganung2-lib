import 'package:e_library_ganung2/pages/register/register_controller.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());

  bool agreement = false;
  bool passInvisible = false;

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.sizeOf(context).width;
    var heightDevice = MediaQuery.sizeOf(context).height;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: widthDevice * 0.1),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                'Daftar sekarang!',
                style: kHeading1,
              ),
            ),
            SizedBox(
              width: widthDevice * 0.8,
              child: Text(
                'Selamat datang! Ayo kita mulai petualangan seru lewat buku!',
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
                textAlignVertical: TextAlignVertical.center,
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
              height: heightDevice * 0.03,
            ),
            Text(
              'Konfirmasi Kata Sandi',
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
                controller: controller.confirmPassController,
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
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: agreement,
                    checkColor: kWhite,
                    focusColor: kWhite,
                    activeColor: kDeepSeaBlue,
                    onChanged: (value) {
                      setState(() {
                        agreement = value!;
                      });
                    },
                  ),
                ),
                Text(
                  ' Saya setuju dengan kebijakan ',
                  style: kKredit2,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'keamanan dan privasi.',
                    style: kLink2,
                  ),
                )
              ],
            ),
            SizedBox(
              height: heightDevice * 0.04,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: agreement ? () {
                    controller.register();
                  } : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDeepSeaBlue,
                      minimumSize: Size(widthDevice * 0.5, 46),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Text(
                    'Daftar',
                    style: kTextButton,
                  )),
            ),
            SizedBox(
              height: heightDevice * 0.05,
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kamu sudah pernah bergabung, ya? Masuk ',
                  style: kKredit1,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/login');
                  },
                  child: Text(
                    'di sini!',
                    style: kLink1,
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
