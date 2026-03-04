

import 'package:flutter/material.dart';

showSnackBar(BuildContext context,{required String message}){
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration:Duration(milliseconds:2000),
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.green,
    ),
  );
}