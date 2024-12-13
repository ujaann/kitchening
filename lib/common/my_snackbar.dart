import 'package:flutter/material.dart';




void showErrorSnackBar(BuildContext context,{required String message}){
  final errorSnackBar=SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}