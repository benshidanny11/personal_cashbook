import 'package:flutter/cupertino.dart';

class EntryModel {
   String? tittle;
   String? type;
   double? amount;
   double? balance;
   String? date;
  double? netBalace;
  double? totalExpences;
  double? totalIncome;

   EntryModel(
      { this.tittle,
       this.amount,
       this.date,
       this.type,
       this.balance,
      this.netBalace,
      this.totalExpences,
      this.totalIncome});
}
