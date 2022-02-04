import 'package:flutter/cupertino.dart';

class EntryModel {
  final String tittle;
  final String type;
  final double amount;
  final double balance;
  final String date;

  const EntryModel(
      {required this.tittle,
      required this.amount,
      required this.date,
      required this.type,
      required this.balance});
}
