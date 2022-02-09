import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/contants/string_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/widgets/date_picker.dart';
import 'package:my_expenses/widgets/drop_down.dart';
import 'package:my_expenses/widgets/inputtext.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    final argData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    EntryModel entryModel = argData['transactionItem'];
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit transaction entry"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputText(
              onTextChange: (value) {
                title = value;
              },
              textInputType: TextInputType.text,
              label: "Transaction title",
              value: entryModel.tittle,
            ),
            const SizedBox(
              height: 10,
            ),
            InputText(
              onTextChange: (value) {
                amount = double.parse(value);
              },
              textInputType: TextInputType.number,
              label: "Amount of transaction",
              value: entryModel.amount.toString(),
            ),
            const SizedBox(
              height: 10,
            ),
            DropDown(
                type: entryModel.type!,
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
              initialValue: entryModel.date,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
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
                },
                child: const Text('Edit transaction'))
          ],
        ),
      ),
    );
  }
}
