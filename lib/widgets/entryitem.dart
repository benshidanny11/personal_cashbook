import 'package:flutter/material.dart';
import 'package:my_expenses/models/EntryModel.dart';

class EntryItem extends StatelessWidget {
  final EntryModel transaction;

  const EntryItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.tittle,
                  style:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  transaction.type == 'Income'
                      ? '(+) ${transaction.amount.toString()}'
                      : '(-) ${transaction.amount.toString()}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: transaction.type == 'Income'
                          ? Colors.green
                          : Colors.red),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                    label: Text(
                  transaction.type,
                  style: const TextStyle(color: Colors.blue),
                )),
                Text(
                  'Balance: ${transaction.balance.toString()}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(transaction.date,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
