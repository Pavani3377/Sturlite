import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required BuildContext context,
  required String title,
  required String description,
  ToastificationType type = ToastificationType.error,
  Color primaryColor = Colors.black,
  Color backgroundColor = Colors.black,
  IconData? icon,
  Duration autoCloseDuration = const Duration(seconds: 3),
  Alignment alignment = Alignment.topCenter,
}) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flat,
    autoCloseDuration: autoCloseDuration,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    description: RichText(
      text: TextSpan(
        text: description,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    alignment: alignment,
    icon: Icon(icon ?? Icons.info, color: type == ToastificationType.error ? Colors.red : Colors.white),
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 26),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
