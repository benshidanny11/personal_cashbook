import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class EntryItem extends StatefulWidget {
  final EntryModel transaction;

  const EntryItem({Key? key, required this.transaction}) : super(key: key);

  @override
  State<EntryItem> createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  var _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200] as Color,
                blurRadius: 3,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.transaction.tittle!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.transaction.type == 'Income'
                    ? '(+) ${widget.transaction.amount.toString()}'
                    : '(-) ${widget.transaction.amount.toString()}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.transaction.type == 'Income'
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
                widget.transaction.type!,
                style: const TextStyle(color: Colors.blue),
              )),
              Text(
                'Balance: ${widget.transaction.balance.toString()}',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  DateFormat('yyyy-MM-dd')
                      .format(widget.transaction.date as DateTime),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
              SizedBox(
                width: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesContants.EDIT_TRANSACTION_ROUTE,
                            arguments: {"transactionItem": widget.transaction});
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.indigo,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                actions: _isDeleting
                                    ? [
                                        const Text(
                                          "Deleting....",
                                          style:
                                              TextStyle(color: Colors.black26),
                                        )
                                      ]
                                    : [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                            },
                                            child: const Text("No")),
                                        TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                _isDeleting = true;
                                              });
                                              await transactionProvider
                                                  .removeTransaction(widget
                                                      .transaction.docId!);
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                  ctx,
                                                  RoutesContants.HOME_ROUTE);
                                            },
                                            child: const Text("Yes"))
                                      ],
                                title: const Text("Delete transaction"),
                                content: const Text(
                                    "Do you realy want to delete this transaction?"),
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
