import 'package:flutter/material.dart';

Widget textField(
    {required BuildContext context,
      TextEditingController? controller,
      required bool obscureText,
      required String hintText,
      required IconData icon,
      required IconData? trailingIcon}) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Colors.yellow),
    ),
    child: Card(
      elevation: 4,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.001),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (value){
                    controller!.text = value;
                  },
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
              Icon(trailingIcon)
            ],
          )),
    ),
  );
}
