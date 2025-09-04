import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/detail_item/book_controller.dart';

class TestPage extends StatelessWidget {
  final BookController bookController = Get.put(BookController(), permanent: true);

  TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    //bookController.fetchBooks();

    return Scaffold(
      appBar: AppBar(title: Text('Tes')),
      body: Obx(() {
        if (bookController.books.isEmpty) {
          return Center(child: Text('Tidak ada data'));
        }

        return ListView.builder(
          itemCount: bookController.books.length,
          itemBuilder: (context, index) {
            final book = bookController.books[index];
            return ListTile(
              leading: Image.network(book.imageUrl),
              title: Text(book.title),
              subtitle: Text(book.author),
            );
          },
        );
      }),
    );
  }
}
