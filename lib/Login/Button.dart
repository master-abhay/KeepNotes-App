import 'package:flutter/material.dart';

Widget loginButton(
    {required BuildContext context,
      required double buttonRadius,
      required double buttonPaddingHorizontal,
      required double buttonPaddingVertical,
      required String buttonText,
      required double textSize,
      required Color textColor,
      required AlignmentGeometry gradientBegin,
      required AlignmentGeometry gradientEnd,
      required List<Color> colorsList,
      required Function execute}) {
  return TextButton(
      onPressed: () {
        execute();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical:
            MediaQuery.of(context).size.height * buttonPaddingVertical,
            horizontal:
            MediaQuery.of(context).size.width * buttonPaddingHorizontal),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonRadius),
            gradient: LinearGradient(
                begin: gradientBegin, end: gradientEnd, colors: colorsList)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ));
}
