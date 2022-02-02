import 'package:flutter/material.dart';

class InputDecor {
  static InputDecoration getInputDecoration(String? label) =>
       InputDecoration(
        hintText: label,
        contentPadding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );
}
