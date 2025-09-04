import 'package:flutter/cupertino.dart';
import '../style/color.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.margin,
    this.padding
  });

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration:  const BoxDecoration(
        color: kWhite,
        boxShadow: [BoxShadow(color: kSurfSeaBlue, offset: Offset(0, 0), spreadRadius: 1, blurRadius: 4)],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: child,
    );
  }
}