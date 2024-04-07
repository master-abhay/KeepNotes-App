import 'package:flutter/material.dart';

Widget loginButton(
    {required BuildContext context,
     required bool loading,
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
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.symmetric(
            vertical:
            MediaQuery.of(context).size.height * buttonPaddingVertical,
            horizontal:
            MediaQuery.of(context).size.width * buttonPaddingHorizontal),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonRadius),
            gradient: LinearGradient(
                begin: gradientBegin, end: gradientEnd, colors: colorsList)),
        child: loading ? const  Center(
          child:  CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white,
          ),
        ):Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: textSize, color: textColor),
          ),
        ),
      ));
}
