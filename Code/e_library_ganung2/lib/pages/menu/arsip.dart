import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:e_library_ganung2/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/book_interaction_controller.dart';
import '../../style/color.dart';
import '../../widget/content_container.dart';
import '../detail_item/book_controller.dart';

class ArsipUI extends StatefulWidget {
  const ArsipUI({super.key});

  @override
  State<ArsipUI> createState() => _ArsipUI();
}

class _ArsipUI extends State<ArsipUI> {
  final controller = Get.put(BookController());
  final interactionController = Get.find<BookInteractionController>();

  final List<String> statuses = ['Tandai', 'Sedang', 'Selesai'];

  @override
  void initState() {
    super.initState();
    interactionController.fetchBooksByStatus();
  }

  @override
  Widget build(BuildContext context) {
    final heightDevice = MediaQuery.of(context).size.height;
    final widthDevice = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: statuses.length,
      child: Scaffold(
        backgroundColor: kSurfSeaBlue,
        appBar: TabBar(
          padding: EdgeInsets.only(
            top: heightDevice * 0.07,
            left: widthDevice * 0.05,
            right: widthDevice * 0.05,
          ),
          indicator: const BoxDecoration(
            color: kWhiteCool,
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 10,
          labelPadding: const EdgeInsets.only(top: 12, bottom: 6),
          unselectedLabelColor: kWhite,
          unselectedLabelStyle: kLabelField,
          labelStyle: kLabelField,
          labelColor: kDeepSeaBlue,
          dividerHeight: 0,
          tabs: const [
            Text('Tanda'),
            Text('Dibaca'),
            Text('Selesai'),
          ],
        ),
        body: ContentContainer(
          margin: const EdgeInsets.only(top: 20),
          height: heightDevice,
          width: widthDevice,
          child: TabBarView(
            children: statuses.map((statusKey) {
              return Obx(() {
                final books = interactionController.booksByStatus[statusKey] ?? [];

                if (books.isEmpty) {
                  return const Center(child: Text("Belum ada buku."));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return ItemCard(
                      title: book.title,
                      author: book.author,
                      imageUrl: book.imageUrl,
                      onPressed: () {
                        Get.toNamed('/detail', arguments: book,);
                      },
                    );
                  },
                );
              });
            }).toList(),
          ),
        ),
      ),
    );
  }
}