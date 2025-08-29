
import 'package:e_library_ganung2/navigation_menu.dart';
import 'package:e_library_ganung2/pages/detail_item/detail_item.dart';
import 'package:e_library_ganung2/pages/login/login_page.dart';
import 'package:e_library_ganung2/pages/register/register_page.dart';
import 'package:e_library_ganung2/testing/fetch_data.dart';
import 'package:get/get.dart';

import '../upload_data_screen.dart';

class Routes {
  static final pages = [
    GetPage(name: '/login', page: () => LoginUI(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 300)),
    GetPage(name: '/register', page: () => RegisterPage(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 300)),
    GetPage(name: '/navigation', page: () => NavigationMenu(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 300)),
    GetPage(name: '/detail', page: () => DetailItem(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 300)),
  ];
}