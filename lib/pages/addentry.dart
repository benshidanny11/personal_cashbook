import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/utils/validator_util.dart';
import 'package:my_expenses/widgets/button.dart';
import 'package:my_expenses/widgets/date_picker.dart';
import 'package:my_expenses/widgets/drop_down.dart';
import 'package:my_expenses/widgets/inputtext.dart';
import 'package:my_expenses/widgets/top_widget.dart';
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

  bool _isLoading = false;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const TopWidget(
            actionName: "Add transaction",
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  InputText(
                    onTextChange: (value) {
                      title = value;
                    },
                    textInputType: TextInputType.text,
                    label: "Transaction title",
                    isInputValid: InputValidation.isInputValid,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputText(
                    onTextChange: (value) {
                      amount = double.parse(value);
                    },
                    textInputType: TextInputType.number,
                    label: "Amount of transaction",
                    isInputValid: InputValidation.isInputValid,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropDown(
                      type: type,
                      onTextChanged: (value) {
                        setState(() {
                          type = value!;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  DatePicker(
                    onDateChanged: (value) {
                      date = value;
                    },
                    initialValue: DateTime.now(),
                    isInputValid: InputValidation.isInputValid,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Button(
                          text: "Add transaction",
                          onButtonClick: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await transactionProvider.addTransaction(
                                    EntryModel(
                                        tittle: title!,
                                        amount: amount!,
                                        date: date!,
                                        type: type));
                              } catch (e) {
                                setState(() {
                                    _isLoading = false;
                                  });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Unknown error"),
                                ));
                              }

                              Navigator.pushReplacementNamed(
                                  context, RoutesContants.HOME_ROUTE);
                            }
                          })
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
