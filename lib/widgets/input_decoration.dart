import 'package:flutter/material.dart';

class InputDecor {
  static InputDecoration getInputDecoration(String? label) =>
   
       InputDecoration(
        hintText: label,
        contentPadding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: InputBorder.none,
      );
}
