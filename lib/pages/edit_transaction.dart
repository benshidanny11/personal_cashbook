import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/contants/string_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/utils/validator_util.dart';
import 'package:my_expenses/widgets/button.dart';
import 'package:my_expenses/widgets/date_picker.dart';
import 'package:my_expenses/widgets/drop_down.dart';
import 'package:my_expenses/widgets/inputtext.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/widgets/top_widget.dart';
import 'package:provider/provider.dart';

class EditTransactionPage extends StatefulWidget {
  const EditTransactionPage({Key? key}) : super(key: key);

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  String? title;
  double? amount;
  String? type;
  DateTime? date;
  final formGlobalKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final argData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    EntryModel entryModel = argData['transactionItem'];
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopWidget(
              actionName: "Edit transaction",
            ),
            Container(
              padding: const EdgeInsets.all(20),
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
                      value: entryModel.tittle,
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
                      value: entryModel.amount.toString(),
                      isInputValid: InputValidation.isInputValid,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropDown(
                        type: entryModel.type!,
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
                      initialValue: entryModel.date,
                      isInputValid: InputValidation.isInputValid,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Button(
                            text: "Edit transaction",
                            onButtonClick: () async {
                              if (formGlobalKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await transactionProvider.updateTransaction(
                                      EntryModel(
                                          tittle: title ?? entryModel.tittle,
                                          amount: amount ?? entryModel.amount,
                                          date: date ?? entryModel.date,
                                          type: type ?? entryModel.type,
                                          docId: entryModel.docId),
                                      entryModel);

                                  Navigator.pushReplacementNamed(
                                      context, RoutesContants.HOME_ROUTE);
                                } catch (error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Unknown error"),
                                  ));
                                }
                              }
                            })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
