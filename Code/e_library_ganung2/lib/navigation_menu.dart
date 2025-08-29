import 'package:e_library_ganung2/pages/menu/arsip.dart';
import 'package:e_library_ganung2/pages/menu/profile.dart';
import 'package:e_library_ganung2/pages/menu/rak.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/pages/menu/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
          animationDuration: const Duration(milliseconds: 800),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: kSurfSeaBlue,
          surfaceTintColor: kWhite,
          backgroundColor: kWhiteCool,
          elevation: 1,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
            controller.selectedIndex.value = index,
          height: 60,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: kLightGrey,),
              selectedIcon: Icon(Icons.home_filled, color: kWhite,),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.library_books_outlined, color: kLightGrey,),
              selectedIcon: Icon(Icons.library_books, color: kWhite,),
              label: 'Rak',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined, color: kLightGrey,),
              selectedIcon: Icon(Icons.favorite, color: kWhite,),
              label: 'Arsip',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: kLightGrey,),
              selectedIcon: Icon(Icons.settings, color: kWhite,),
              label: 'Profil',
            ),
          ])),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = <Widget>[
    HomeUI(),
    RakUI(),
    const ArsipUI(),
    const Profile(),
  ];
}
