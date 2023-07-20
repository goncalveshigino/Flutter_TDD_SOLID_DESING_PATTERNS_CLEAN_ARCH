
import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red.shade900,
      content: Text(error, textAlign: TextAlign.center,)
    )
  );
}