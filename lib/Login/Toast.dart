import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utils{



  showToast({required String message}){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.green,
      fontSize: 16.0
  );
}
}