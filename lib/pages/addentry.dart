import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/widgets/date_picker.dart';
import 'package:my_expenses/widgets/drop_down.dart';
import 'package:my_expenses/widgets/inputtext.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEntry extends StatefulWidget {
  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  String? title;

  String type = "Income";

  DateTime? date;

  double? amount;

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      
      body: Stack(
        children: [
           Container(color:Colors.indigo,height: 250,),
          Positioned(
            top: 50,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 350,
                    child: Column(
                    children: [
                      InputText(
                        onTextChange: (value) {
                          title = value;
                        },
                        textInputType: TextInputType.text,
                        label: "Transaction title",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          onTextChange: (value) {
                            amount = double.parse(value);
                          },
                          textInputType: TextInputType.number,
                          label: "Amount of transaction"),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDown(
                          type: type,
                          onTextChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DatePicker(
                        onDateChanged: (value) {
                          date = value;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await transactionProvider.addTransaction(EntryModel(
                                tittle: title!,
                                amount: amount!,
                                date: date!,
                                type: type));
                            Navigator.pushReplacementNamed(
                                context, RoutesContants.HOME_ROUTE);
                          },
                          child: const Text('Add transaction'))
                    ],
                          ),
                  ),
                ),
              ),
             
            ),
          ),
        ]
      ),
    );
  }
}
