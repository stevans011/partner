import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import 'Colors.dart';

//contains two methods for showing toast messages using the fluttertoast package in a Flutter application.
// Toast messages are small pop-up notifications that appear at the bottom of the screen and disappear after a short period.
class ShowToast {

  //showNormalToast method takes a required parameter msg, which represents the message text to be shown in the toast.

  void showNormalToast({required String msg}) {
    //It uses the Fluttertoast.showToast method to display the toast message.
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT, //The method is configured to show the toast for a short duration (Toast.LENGTH_SHORT),
        gravity: ToastGravity.BOTTOM, // set positioned at the bottom of the screen .
//          timeInSecForIos: 1,
        backgroundColor: const Color(0xff666666), //The background color of the toast is set to a specific color
        textColor: AppThemeColor.pureWhiteColor, //msg text color is set to a color from the AppThemeColor class named pureWhiteColor.
        fontSize: 16.0); //The font size of the message text is set to 16.0.
  }

  //showLongToast method is  configured to show the toast for a longer duration.
  void showLongToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
        backgroundColor: const Color(0xff666666),
        textColor: AppThemeColor.pureWhiteColor,
        fontSize: 16.0);
  }
}
