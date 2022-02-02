import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/widgets/input_decoration.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime? value)? onDateChanged;

  const DatePicker({Key? key, required this.onDateChanged}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        format: DateFormat("yyyy-MM-dd"),
        decoration: InputDecor.getInputDecoration("Choose date"),
        onChanged: widget.onDateChanged,
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        });
  }
}
