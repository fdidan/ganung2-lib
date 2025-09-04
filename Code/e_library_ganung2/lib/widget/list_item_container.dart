import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListItemContainer extends StatelessWidget {
  List<Widget> children = const <Widget>[];

  ListItemContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 6, bottom: 60),
      children: children
    );
  }
}