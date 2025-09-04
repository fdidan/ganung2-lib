import 'package:flutter/material.dart';
import '../style/color.dart';
import '../style/textstyle.dart';

class SearchBarCard extends StatelessWidget {
  const SearchBarCard({
    super.key,
    this.margin,
    this.onChanged,
    this.onSubmitted,
    this.onTapOutside
  });

  final EdgeInsetsGeometry? margin;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: kDeepSeaBlue, width: 2),
              bottom: BorderSide(color: kDeepSeaBlue, width: 2),
              right: BorderSide(color: kDeepSeaBlue, width: 2),
              left: BorderSide(color: kDeepSeaBlue, width: 2)),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: SearchBar(
        hintText: 'Mau baca apa hari ini?',
        hintStyle: WidgetStatePropertyAll(kLabelField2),
        textStyle: WidgetStatePropertyAll(kBodyNormal),
        backgroundColor: const WidgetStatePropertyAll(kWhite),
        leading: const Icon(
          Icons.search,
          color: kDeepSeaBlue,
          size: 30,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTapOutside: onTapOutside
      ),
    );
  }
}
