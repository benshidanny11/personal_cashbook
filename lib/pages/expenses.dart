import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/widgets/entryitem.dart';
import 'package:my_expenses/widgets/upper_info.dart';
import 'package:provider/provider.dart';

class ExpencesScreen extends StatelessWidget {
  const ExpencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    //EntryItem()
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          const UpperData(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(color: Colors.grey[300], height: 1, width: 50),
                 Text("All transactions (${transactionProvider.transactions.length})"),
                Container(
                  color: Colors.grey[300],
                  width: 50,
                  height: 1,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return EntryItem(
                    transaction: transactionProvider.transactions[index]);
              },
              itemCount: transactionProvider.transactions.length,
            ),
          )
        ],
      ),
    );
  }
}
