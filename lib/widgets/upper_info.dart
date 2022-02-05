import 'package:flutter/material.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class UpperData extends StatefulWidget {
  const UpperData({Key? key}) : super(key: key);

  @override
  State<UpperData> createState() => _UpperDataState();
}

class _UpperDataState extends State<UpperData> {
  var _isInit = true;
  EntryModel? entry;
  @override
  void didChangeDependencies() async{
    if (_isInit) {
      final transactionProvider = Provider.of<TransactionProvider>(context);

      entry =await transactionProvider.lastTransaction;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                 const Text(
                    "Net balance: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(entry!.netBalace!=null?entry!.netBalace.toString():"0",
                      style:
                         const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ]),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text(
                  "Total income",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Text(
                   entry!.totalIncome!=null?entry!.totalIncome.toString():"0",
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.green),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text(
                  "Total Expenses: ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Text(
                  entry!.totalExpences!=null?entry!.totalExpences.toString():"0",
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
