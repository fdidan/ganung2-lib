import 'package:e_library_ganung2/widget/searc_bar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style/color.dart';
import '../../style/textstyle.dart';
import '../../widget/content_container.dart';
import '../../widget/item.dart';
import '../detail_item/book_controller.dart';

class RakUI extends StatelessWidget {
  RakUI({super.key});

  final booksController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    final heightDevice = context.height;
    final widthDevice = context.width;

    return Scaffold(
      backgroundColor: kSurfSeaBlue,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: kSurfSeaBlue,
        title: SearchBarCard(
          margin: EdgeInsets.symmetric(
            vertical: widthDevice * 0.05,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ContentContainer(
            width: widthDevice,
            padding: EdgeInsets.only(top: 16, left: widthDevice * 0.05, right: widthDevice * 0.05,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Koleksi Baru', style: kLabelCategory,),
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Obx(() =>  ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: booksController.newBooks.length,
                        itemBuilder: (context, index){
                          final newBooks = booksController.newBooks[index];
                          return ItemCard(
                              author: newBooks.author,
                              title: newBooks.title,
                              imageUrl: newBooks.imageUrl,
                              onPressed: () => Get.toNamed('/detail', arguments: newBooks)
                          );
                        }
                    ),)
                ),
                SizedBox(height: 16,),
                Text('Koleksi', style: kLabelCategory,),
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Obx(() =>  ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: booksController.oldBooks.length,
                        itemBuilder: (context, index){
                          final oldBook = booksController.oldBooks[index];
                          return ItemCard(
                              author: oldBook.author,
                              title: oldBook.title,
                              imageUrl: oldBook.imageUrl,
                              onPressed: () => Get.toNamed('/detail', arguments: oldBook)
                          );
                        }
                    ),)
                ),
                SizedBox(height: 16,),
                Text('Koleksi', style: kLabelCategory,),
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Obx(() =>  ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: booksController.randomBooks.length,
                        itemBuilder: (context, index){
                          final randomBook = booksController.randomBooks[index];
                          return ItemCard(
                              author: randomBook.author,
                              title: randomBook.title,
                              imageUrl: randomBook.imageUrl,
                              onPressed: () => Get.toNamed('/detail', arguments: randomBook)
                          );
                        }
                    ),)
                ),
              ],
            )
        ),
      )
    );
  }
}