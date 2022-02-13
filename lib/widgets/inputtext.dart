import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class InputText extends StatelessWidget {
  final Function(String value) onTextChange;
  final TextInputType textInputType;
  final String label;
  final String? value;
  final bool Function(String value)? isInputValid;
  const InputText(
      {Key? key,
      required this.onTextChange,
      required this.textInputType,
      required this.label,
      this.isInputValid,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300] as Color,
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: TextFormField(
        onChanged: onTextChange,
        keyboardType: textInputType,
        initialValue: value,
        decoration: InputDecor.getInputDecoration(label),
        validator: (value) {
          if (isInputValid!(value as String)) {
            return null;
          } else {
            return 'Enter $label';
          }
        },
      ),
    );
  }
}
