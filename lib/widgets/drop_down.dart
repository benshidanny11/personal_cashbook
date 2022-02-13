import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class DropDown extends StatelessWidget {
  final String type;
  final Function(String? value) onTextChanged;
  const DropDown({Key? key, required this.type, required this.onTextChanged})
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
      child: DropdownButtonFormField<String>(
        value: type,
        elevation: 16,
        decoration: InputDecor.getInputDecoration("Transaction type"),
        onChanged: onTextChanged,
        items: <String>["Income", "Expense"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
