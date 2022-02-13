import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime? value)? onDateChanged;
  final DateTime? initialValue;
  final bool Function(String value)? isInputValid;

  const DatePicker(
      {Key? key,
      required this.onDateChanged,
      this.initialValue,
      this.isInputValid})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
      child: DateTimeField(
          format: DateFormat("yyyy-MM-dd"),
          decoration: InputDecor.getInputDecoration("Choose date"),
          onChanged: widget.onDateChanged,
          initialValue: widget.initialValue,
          validator: (value) {
            if (widget.isInputValid!(value.toString())) {
              return null;
            } else {
              return "Please choose date";
            }
          },
          onShowPicker: (context, currentValue) async {
            return await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          ),
    );
  }
}
