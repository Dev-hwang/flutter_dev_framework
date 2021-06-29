import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 토스트 메시지 길이
enum AndroidToastLength {
  SHORT,
  LONG
}

/// 토스트 메시지 위치
enum AndroidToastGravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR
}

/// 안드로이드 토스트 메시지
class AndroidToast {
  final String message;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final AndroidToastLength length;
  final AndroidToastGravity gravity;

  const AndroidToast({
    required this.message,
    this.fontSize = 15.0,
    this.fontColor = Colors.white,
    this.backgroundColor = Colors.black54,
    this.length = AndroidToastLength.SHORT,
    this.gravity = AndroidToastGravity.BOTTOM
  });

  Future<bool?> show() async {
    return await Fluttertoast.showToast(
      msg: message,
      fontSize: fontSize,
      textColor: fontColor,
      backgroundColor: backgroundColor,
      gravity: _parseGravity(gravity),
      toastLength: (length == AndroidToastLength.SHORT)
          ? Toast.LENGTH_SHORT
          : Toast.LENGTH_LONG,
      timeInSecForIosWeb: (length == AndroidToastLength.SHORT)
          ? 2
          : 4
    );
  }

  ToastGravity _parseGravity(AndroidToastGravity gravity) {
    switch (gravity) {
      case AndroidToastGravity.TOP:
        return ToastGravity.TOP;
      case AndroidToastGravity.CENTER:
        return ToastGravity.CENTER;
      case AndroidToastGravity.TOP_LEFT:
        return ToastGravity.TOP_LEFT;
      case AndroidToastGravity.TOP_RIGHT:
        return ToastGravity.TOP_RIGHT;
      case AndroidToastGravity.BOTTOM_LEFT:
        return ToastGravity.BOTTOM_LEFT;
      case AndroidToastGravity.BOTTOM_RIGHT:
        return ToastGravity.BOTTOM_RIGHT;
      case AndroidToastGravity.CENTER_LEFT:
        return ToastGravity.CENTER_LEFT;
      case AndroidToastGravity.CENTER_RIGHT:
        return ToastGravity.CENTER_RIGHT;
      case AndroidToastGravity.SNACKBAR:
        return ToastGravity.SNACKBAR;
      default:
        return ToastGravity.BOTTOM;
    }
  }
}
