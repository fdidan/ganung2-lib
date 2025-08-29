import 'package:flutter/material.dart';

import '../style/color.dart';
import '../style/textstyle.dart';

class StatusButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ?kWhiteCool : kDeepSeaBlue,
        foregroundColor: Colors.white,
        fixedSize: const Size(120, 50),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: isSelected ? BorderSide(
            color: kDeepSeaBlue,
            width: 2
        ) : null,
      ),
      child: isSelected ? Text(label, style: kTextButtonLight,) : Text(label, style: kTextButton2) ,
    );
  }
}
