import 'package:flutter/cupertino.dart';

class EntryModel {
  String? tittle;
  String? docId;
  String? type;
  double? amount;
  double? balance;
  DateTime? date;

  EntryModel(
      {this.tittle,
      this.amount,
      this.date,
      this.type,
      this.balance,
      this.docId});
}
