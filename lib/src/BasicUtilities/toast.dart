import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class ToastAndSnackbar{
    static showToast(String message, Color color) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        textColor:  ShopperColor.appColorBlack85,
        backgroundColor: color,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
}