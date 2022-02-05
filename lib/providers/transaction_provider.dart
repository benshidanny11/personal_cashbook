import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_expenses/models/EntryModel.dart';
import 'package:my_expenses/utils/apputils.dart';

class TransactionProvider with ChangeNotifier {
  List<EntryModel> _transactions = [];

  List<EntryModel> get transactions {
    return [..._transactions];
  }

  var userEmail = FirebaseAuth.instance.currentUser!.email;
  final _firestore = FirebaseFirestore.instance;

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
        "net_balance": transaction.amount,
        "total_income": transaction.type == 'Income'
            ? transaction.amount
            : (transaction.amount)! * -1,
        "total_expenses": 0,
        "balance": transaction.amount,
        "created_on": time
      };
    } else {
      final expenses = await _firestore
          .collection(AppUtils.getSuBEmail(userEmail!))
          .orderBy('created_on', descending: true)
          .get();

      var lastDoc = expenses.docs.first;

      var totalIn = transaction.type == "Income"
          ? lastDoc.data()['total_income'] + transaction.amount
          : lastDoc.data()['total_income'];
      var totalEx = transaction.type == "Expense"
          ? lastDoc.data()['total_expenses'] + transaction.amount
          : lastDoc.data()['total_expenses'];
      var netBalance = transaction.type == "Income"
          ? lastDoc.data()['net_balance'] + transaction.amount
          : lastDoc.data()['net_balance'] - transaction.amount;
      var balance = transaction.type == "Income"
          ? lastDoc.data()['balance'] + transaction.amount
          : lastDoc.data()['balance'] - transaction.amount;
      trans = {
        "title": transaction.tittle,
        "type": transaction.type,
        "done_on": transaction.date,
        "amount": transaction.amount,
        "net_balance": netBalance,
        "total_income": totalIn,
        "total_expenses": totalEx,
        "balance": balance,
        "created_on": time
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
          date: expense.data()['done_on'],
          type: expense.data()['type'],
          balance: expense.data()['balance']));
    }

    // sortedTransactions.sort((a, b) => a["timestamp"].compareTo(b["timestamp"]));
    notifyListeners();
  }

  Future<int> _getDocSize() async {
    var expenses =
        await _firestore.collection(AppUtils.getSuBEmail(userEmail!)).get();
    return expenses.docs.length;
  }

  Future<EntryModel> get lastTransaction async {
    final expenses = await _firestore
        .collection(AppUtils.getSuBEmail(userEmail!))
        .orderBy("created_on",descending: true)
        .get();

    var lastdoc = expenses.docs.first;

    return EntryModel(
        totalExpences: lastdoc.data()['total_expenses'],
        totalIncome: lastdoc.data()['total_income'],
        netBalace: lastdoc.data()['net_balance']);
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
}
