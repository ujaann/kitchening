import 'package:flutter/material.dart';
import 'package:kitchening/app/common/styles.dart';

void showErrorSnackBar(BuildContext context, {required String message}) {
  final errorSnackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}

void showSuccessSnackBar(BuildContext context, {required String message}) {
  final errorSnackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: lightBlue,
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}
