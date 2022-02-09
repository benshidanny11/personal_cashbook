import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class InputText extends StatelessWidget {
  final Function(String value) onTextChange;
  final TextInputType textInputType;
  final String label;
  final String? value;
  const InputText(
      {Key? key,
      required this.onTextChange,
      required this.textInputType,
      required this.label,this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onTextChange,
      keyboardType: textInputType,
      initialValue: value,
      decoration: InputDecor.getInputDecoration(label),
    );
  }
}
