import 'package:clean_architecture_demo/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

/// gives the current screen width
double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

/// gives the current screen height
double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double getTodoCardTextAreaWidth(BuildContext context) => getScreenWidth(context) * 0.7;


String getTodoCardDisplayDate(DateTime date) {
  final DateFormat formatter = DateFormat('MMMM dd');
  return formatter.format(date).toString();
}

void showShortToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLongToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}
