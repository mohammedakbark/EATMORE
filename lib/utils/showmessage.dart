import 'package:flutter/material.dart';

showSuccessSnackBar(context, String content, bgcolor) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    behavior: SnackBarBehavior.floating,
    backgroundColor: bgcolor,
    elevation: 20,
    margin: EdgeInsets.all(10),
  ));
}
