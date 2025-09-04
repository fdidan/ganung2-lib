import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_library_ganung2/style/color.dart';
import 'package:e_library_ganung2/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemCard extends StatelessWidget{
  final String? title;
  final String? author;
  final String? imageUrl;
  final VoidCallback onPressed;

  const ItemCard({
    super.key,
    required this.author,
    required this.title,
    required this.imageUrl,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        height: 300,
        width: 140,
        decoration: const BoxDecoration(
          color: kWhite,
          border: Border(
              top: BorderSide(color: kLightGrey, width: 0.5),
              bottom: BorderSide(color: kLightGrey, width: 0.5),
              right: BorderSide(color: kLightGrey, width: 0.5),
              left: BorderSide(color: kLightGrey, width: 0.5)),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image(
                  height: 120,
                  image: NetworkImage(imageUrl ?? '')), //ToDo: tambahkan url default cover untuk buku yg link error/tidak ada
            ),
            SizedBox(height: 4,),
            AutoSizeText(
              author ?? 'Tanpa penulis',
              style: kKredit2,
              textAlign: TextAlign.start,
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4,),
            AutoSizeText(
              title ?? '',
              style: kBodyNormal2,
              textAlign: TextAlign.start,
              maxLines: 2,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}