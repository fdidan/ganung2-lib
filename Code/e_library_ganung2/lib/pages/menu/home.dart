import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_library_ganung2/controllers/book_interaction_controller.dart';
import 'package:e_library_ganung2/controllers/personalized_recommendation_controller.dart';
import 'package:e_library_ganung2/pages/detail_item/book_controller.dart';
import 'package:e_library_ganung2/repositories/auth.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:e_library_ganung2/widget/content_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/item.dart';
import '../../widget/searc_bar_card.dart';

class HomeUI extends StatelessWidget {
  HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    final heightDevice = MediaQuery.sizeOf(context).height;
    final widthDevice = MediaQuery.sizeOf(context).width;

    final User? user = Auth().currentUser;
    final booksController = Get.put(BookController());
    final personalizedRecController = Get.put(PersonalizedRecommendationController());
    final interactedBookController = Get.put(BookInteractionController());
    final RxBool isClose = false.obs;
    final String? username = user?.email.toString();

    return Scaffold(
      backgroundColor: kSurfSeaBlue,
        appBar: AppBar(
          title: Text(
            'Halo $username! \nBaca apa hari ini?',
            style: kHeading2,
          ),
          backgroundColor: kSurfSeaBlue,
          toolbarHeight: 60,
        ),
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
                isClose.value = true;
              },
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: widthDevice * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchBarCard(
                            onSubmitted: (value){
                              booksController.searchQuery.value = value;
                              Get.toNamed('/search', arguments: booksController.searchQuery.value);
                            },
                            onChanged: (value){
                              booksController.searchQuery.value = value;
                              isClose.value = false;
                            },
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              isClose.value = true;
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kategori', style: kLightLabelCategory,),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          backgroundColor: kWhiteCool,radius: 36,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text('Fantasi', style: kBodyNormal,)
                                            )
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ContentContainer(
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
                          Text('Kamu akan suka ini!', style: kLabelCategory,),
                          SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Obx(() =>  ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: personalizedRecController.recommendedBooks.length,
                                  itemBuilder: (context, index) {
                                    final recommendedBook = personalizedRecController.recommendedBooks[index];
                                    return ItemCard(
                                        author: recommendedBook.author,
                                        title: recommendedBook.title,
                                        imageUrl: recommendedBook.imageUrl,
                                        onPressed: () => Get.toNamed('/detail', arguments: recommendedBook)
                                    );
                                  }
                              ),)
                          ),
                          SizedBox(height: 16,),
                          Text('Mau coba yang agak beda?', style: kLabelCategory,),
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
                                        title: randomBook.title ,
                                        imageUrl: randomBook.imageUrl,
                                        onPressed: () => Get.toNamed('/detail', arguments: randomBook)
                                    );
                                  }
                              ),)
                          ),
                          SizedBox(height: 16,),
                          Text('Yuk! Lanjut baca!', style: kLabelCategory,),
                          SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Obx(() {
                                final interactedBooks = interactedBookController.booksByStatus['Tandai']
                                    ?? interactedBookController.booksByStatus['Sedang'] ?? [];

                                if(interactedBooks.isEmpty) return SizedBox.fromSize(size: Size(20, 20),);

                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: interactedBooks.length,
                                    itemBuilder: (context, index){
                                      final interactedBook = interactedBooks[index];
                                      return ItemCard(
                                          author: interactedBook.author,
                                          title: interactedBook.title ,
                                          imageUrl: interactedBook.imageUrl,
                                          onPressed: () => Get.toNamed('/detail', arguments: interactedBook)
                                      );
                                    }
                                );
                              })
                          ),
                        ],
                      )
                    ),
                    ],
                  ),
              ),
            ),
            Obx((){
              final results = booksController.filteredBooks;
              final query = booksController.searchQuery.value;

              if(query.isEmpty || isClose.value) return SizedBox.shrink();
              return Positioned(
                  top: 50,
                  left: widthDevice * 0.05,
                  right: widthDevice * 0.05,
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      constraints: BoxConstraints(
                        maxHeight: 400,
                        minHeight: 0,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        border: Border(
                          left: BorderSide(color: kDeepSeaBlue, width: 2),
                          right: BorderSide(color: kDeepSeaBlue, width: 2),
                          bottom: BorderSide(color: kDeepSeaBlue, width: 2)
                        )
                      ),
                      child: results.isEmpty ?
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Buku tidak ditemukan'),
                      ) :
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: booksController.books.length,
                          itemBuilder: (context, index){
                            if (index >= booksController.filteredBooks.length) return const SizedBox(); // fallback aman
                            final book = results[index];
                            return ListTile(
                              leading: Image.network(book.imageUrl, height: 60, width: 40, fit: BoxFit.cover,),
                              title: AutoSizeText(book.title, style: kLabelCategory, overflow: TextOverflow.ellipsis,),
                              subtitle: AutoSizeText(book.author, style: kBodyNormal, overflow: TextOverflow.ellipsis,),
                              onTap: () {
                                print('Taped on : ${book.title}',);
                                Get.toNamed('/detail', arguments: book);
                                booksController.searchQuery.value = '';
                              },
                            );
                          }
                      )
                    ),
                  )
              );
            })
          ]
        )
    );
  }
}
