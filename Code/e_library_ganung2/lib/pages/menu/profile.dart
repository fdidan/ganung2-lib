import 'package:e_library_ganung2/pages/detail_item/book_controller.dart';
import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:e_library_ganung2/widget/content_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/list_tile_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  @override
  Widget build(BuildContext context) {
    final heightDevice = context.height;
    final widthDevice = context.width;

    final userName = Auth().currentUser?.email;

    return Scaffold(
      backgroundColor: kSurfSeaBlue,
      appBar: PreferredSize(
          preferredSize: Size(
              widthDevice,
              heightDevice * 0.3
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  '$userName',
                style: kHeading2,
              ),
              const SizedBox(height: 12,),
              Text(
                  'Kelas',
                style: kLightLabelCategory,
              ),
              const SizedBox(height: 12,),
              const Image(
                  image: AssetImage('assets/images/google_logo.png'),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 32,)
            ],
          ),
      ),
      body:  ContentContainer(
        padding: EdgeInsets.only(top: 24, left: widthDevice * 0.05, right: widthDevice * 0.05, bottom: 16),
          width: widthDevice,
          height: heightDevice * 0.9,
          child:ListView(
            children: [
              ListTileItem(
                title: Text('Akun'),
                icon: Icon(Icons.account_circle_rounded),
              ),
              ListTileItem(
                title: Text('Keamanan'),
                icon: Icon(Icons.privacy_tip),
              ),
              ListTileItem(
                title: Text('Notifikasi'),
                icon: Icon(Icons.notifications_active),
              ),
              ListTileItem(
                title: ElevatedButton(onPressed: () {
                  BookController().forceRefresh();
                },
                child: Text('Refresh Data')),
                icon: Icon(Icons.notifications_active),
              ),
            ],
          )
      ),
      floatingActionButton: SizedBox(
        width: widthDevice * 0.8,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Keluar',
                titleStyle: kLabelField,
                middleText: 'Yakin ingin keluar?',
                textConfirm: 'Ya',
                textCancel: 'Tidak',
                confirmTextColor: kWhite,
                backgroundColor: kWhite,
                buttonColor: kDeepSeaBlue,
                onConfirm: () async {
                  await Auth().signOut();
                  Get.offAllNamed('/login');
                },
              );
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(kRed),
            ),
            child: Text(
                'Keluar',
              style: kTextButton,
            )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
