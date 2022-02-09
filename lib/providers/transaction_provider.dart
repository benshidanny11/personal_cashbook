import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_expenses/contants/string_constants.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/models/upperdatamodel.dart';
import 'package:my_expenses/pages/expenses.dart';
import 'package:my_expenses/utils/apputils.dart';
import 'package:my_expenses/widgets/upper_info.dart';

class TransactionProvider with ChangeNotifier {
  List<EntryModel> _transactions = [];

  List<EntryModel> get transactions {
    return [..._transactions];
  }

  var userEmail = FirebaseAuth.instance.currentUser!.email;
  final _firestore = FirebaseFirestore.instance;

  /*
   trans = {
        "title": transaction.tittle,
        "type": transaction.type,
        "done_on": transaction.date,
        "amount": transaction.amount,
        "net_balance": transaction.amount,
        "total_income": transaction.type == 'Income'
            ? transaction.amount
            : (transaction.amount)! * -1,
        "total_expenses": 0.0,
        "balance": transaction.amount,
        "created_on": time
      };
  
  
  */

  Future<void> addTransaction(EntryModel transaction) async {
    int docSize = await _getDocSize();
    Map<String, dynamic> trans;
    var time = DateTime.now();

    if (docSize == 0) {
      trans = {
        "title": transaction.tittle,
        "type": transaction.type,
        "done_on": transaction.date,
        "amount": transaction.amount,
        "balance": transaction.amount,
        "created_on": time
      };
    } else {
      final expenses = await _firestore
          .collection(AppUtils.getSuBEmail(userEmail!))
          .orderBy('created_on', descending: true)
          .get();

      var balance =
          (await totalIncome - await totalExpenses) - transaction.amount!;
      trans = {
        "title": transaction.tittle,
        "type": transaction.type,
        "done_on": transaction.date,
        "amount": transaction.amount,
        "balance": balance,
        "created_on": time,
      };
    }
    CollectionReference expences =
        _firestore.collection(AppUtils.getSuBEmail(userEmail!));

    expences.add(trans);
    notifyListeners();
  }

  Future<void> getExpenses() async {
    _transactions = [];
    final expenses = await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .orderBy('created_on', descending: true)
        .get();

    for (var expense in expenses.docs) {
      _transactions.add(EntryModel(
          tittle: expense.data()['title'],
          amount: expense.data()['amount'],
          type: expense.data()['type'],
          balance: expense.data()['balance'],
          docId: expense.id,
          date: expense.data()['done_on'].toDate()));
    }
    notifyListeners();
  }

  Future<int> _getDocSize() async {
    var expenses =
        await _firestore.collection(AppUtils.getSuBEmail(userEmail!)).get();
    return expenses.docs.length;
  }

  Future<double> get totalIncome async {
    final expenses = await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .orderBy("created_on", descending: true)
        .get();
    var total = 0.0;
    for (var income in expenses.docs) {
      if (income.data()['type'] == 'Income') {
        total += income.data()['amount'];
      }
    }
    return total;
  }

  Future<double> get totalExpenses async {
    final expenses = await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .orderBy("created_on", descending: true)
        .get();
    var total = 0.0;
    for (var expense in expenses.docs) {
      if (expense.data()['type'] == 'Expense') {
        total += expense.data()['amount'];
      }
    }
    return total;
  }

  Future<UpperDataModel> get upperData async {
    final expenses = await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .orderBy("created_on", descending: true)
        .get();
    var totalIn = 0.0;
    for (var expense in expenses.docs) {
      if (expense.data()['type'] == 'Income') {
        totalIn += expense.data()['amount'];
      }
    }

    var totalEx = 0.0;
    for (var expense in expenses.docs) {
      if (expense.data()['type'] == 'Expense') {
        totalEx += expense.data()['amount'];
      }
    }

    var netBalance = totalIn - totalEx;
    return UpperDataModel(
        totalIncome: totalIn, totalExpenses: totalEx, netBalance: netBalance);
  }

  Future<void> updateTransaction(
      EntryModel transaction, EntryModel prevTrans) async {
    var time = DateTime.now();

    var trans = {
      "title": transaction.tittle,
      "type": transaction.type,
      "done_on": transaction.date,
      "amount": transaction.amount,
      "created_on": time,
    };
    await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .doc(transaction.docId)
        .update(trans);

    notifyListeners();
  }

  Future<void> removeTransaction(String docId) async {
    await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .doc(docId)
        .delete();
    notifyListeners();
  }
}
