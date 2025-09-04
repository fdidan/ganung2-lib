import 'package:e_library_ganung2/controllers/book_interaction_controller.dart';
import 'package:e_library_ganung2/controllers/recommendation_controller.dart';
import 'package:e_library_ganung2/model/book_model.dart';
import 'package:e_library_ganung2/pages/detail_item/book_controller.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:e_library_ganung2/widget/content_container.dart';
import 'package:e_library_ganung2/widget/status_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/item.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({
    super.key,
  });

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    final Book book = Get.arguments;
    final controller = Get.put(BookController());
    final recommendedController = Get.put(RecommendationController());
    final interactionController = Get.find<BookInteractionController>();
    interactionController.loadStatus(book.id);
    recommendedController.fetchRecommendations(book.id);


    return Scaffold(
      backgroundColor: kWhiteCool,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: kDeepSeaBlue,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: kWhite,),
        ),
        title: Text(book.title),
        titleTextStyle: kLightLabelCategory,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 100),
        children: [
          Text(book.title, style: kHeading3, textAlign: TextAlign.center,),
          const SizedBox(height: 8,),
          Text(book.author, style: kLabelField, textAlign: TextAlign.center,),
          const SizedBox(height: 16,),
          Image.network(
            book.imageUrl,
            height: 200,
            width: 100,
          ),
          const SizedBox(height: 24,),
          Text(
            book.description,
            style: kBodyNormal,
            textAlign: TextAlign.justify,
          ),
          Container(
            width: context.width,
            height: 2,
            color: kDarkGrey,
            margin: const EdgeInsets.symmetric(vertical: 16),
          ),
          Text('Serupa', style: kLabelCategory,),
          SizedBox(
            height: 200,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedController.recommendedBooks.length,
                itemBuilder: (context, index) {
                  final book = recommendedController.recommendedBooks[index];
                  return ItemCard(
                    onPressed: () {
                      print(book.title);
                      Get.offAndToNamed('/detail', arguments: book);
                    },
                    author: book.author,
                    title: book.title,
                    imageUrl: book.imageUrl,
                  );
                },
              );
            })
          ),
        ],
      ),
      floatingActionButton: ContentContainer(
            width: context.width,
            height: 100,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx((){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(
                  label: 'Tandai',
                  isSelected: interactionController.status.value == 'tandai',
                  onTap: () => interactionController.setStatus(book.id, 'tandai'),
                ),
                StatusButton(
                  label: 'Sedang dibaca',
                  isSelected: interactionController.status.value == 'sedang',
                  onTap: () => interactionController.setStatus(book.id, 'sedang'),
                ),
                StatusButton(
                  label: 'Selesai dibaca',
                  isSelected: interactionController.status.value == 'selesai',
                  onTap: () => interactionController.setStatus(book.id, 'selesai'),
                ),
              ],
            );
            }
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
