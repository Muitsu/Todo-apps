import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlusbar {
  static Future showSuccess(BuildContext context,
      {required String message, Color? color}) async {
    return Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.check_circle,
        size: 28.0,
        color: color ?? const Color.fromARGB(255, 54, 247, 128),
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  static Future showUnsuccess(BuildContext context,
      {required String message}) async {
    return Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(
        Icons.cancel,
        size: 28.0,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  static Future showError(BuildContext context, {required String msg}) async {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      padding: const EdgeInsets.all(20),
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      message: msg,
    ).show(context);
  }
}
