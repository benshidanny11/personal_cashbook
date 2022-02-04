
import 'package:flutter/cupertino.dart';
import 'package:my_expenses/models/EntryModel.dart';

class TransactionProvider with ChangeNotifier{

  List<EntryModel> _transactions=[];

  List<EntryModel> get transactions {
    return [..._transactions];
  }

  Future<void> addTransaction(EntryModel transaction) async{
    _transactions.add(transaction);
    notifyListeners();
  }
}