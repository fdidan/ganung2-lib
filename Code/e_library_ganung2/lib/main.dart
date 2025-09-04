import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:e_library_ganung2/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await GetStorage.init();
  FirebaseDatabase.instance.setLoggingEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Auth().currentUser;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? '/navigation' : '/login',
      //initialRoute: '/navigation',
      getPages: Routes.pages,
    );
  }
}
