import 'package:flutter/material.dart';

import '../style/color.dart';
import '../style/textstyle.dart';

class ListTileItem extends StatelessWidget {
  final Widget? icon;
  final Widget title;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ListTileItem({
    super.key,
    required this.title,
    this.icon,
    this.margin,
    this.padding,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: kLightGrey, width: 0.5),
              bottom: BorderSide(color: kLightGrey, width: 0.5),
              right: BorderSide(color: kLightGrey, width: 0.5),
              left: BorderSide(color: kLightGrey, width: 0.5)),
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: ListTile(
        title: title,
        titleTextStyle: kLabelField,
        trailing: icon,
      ),
    );
  }
}