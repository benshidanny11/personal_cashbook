import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/pages/expenses.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(title),
      ),
      body: const ExpencesScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
         Navigator.pushReplacementNamed(context, RoutesContants.ADD_ENTRY);
        },
      ),
    );
  }
}
