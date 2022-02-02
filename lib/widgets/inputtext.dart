import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class InputText extends StatelessWidget {
  final Function(String value) onTextChange;
  final TextInputType textInputType;
  final String label;
  const InputText(
      {Key? key,
      required this.onTextChange,
      required this.textInputType,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onTextChange,
        keyboardType: textInputType,
        decoration:  InputDecor.getInputDecoration(label),
    );
  }
}
