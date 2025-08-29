import 'package:e_library_ganung2/repositories/upload_data_controller.dart';
import 'package:flutter/material.dart';

class UploadBooksPage extends StatelessWidget {
  final controller = UploadBooksController();

  UploadBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Buku ke Firestore')),
      body: Center(
        child: ElevatedButton(
          onPressed: controller.uploadBooksFromJson,
          child: Text("Upload Sekarang"),
        ),
      ),
    );
  }
}
