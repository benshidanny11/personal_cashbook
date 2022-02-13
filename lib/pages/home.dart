import 'package:firebase_auth/firebase_auth.dart';
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
        actions: [
          IconButton(
              onPressed: () async {
               await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(
                    context, RoutesContants.SIGNIN_ROUTE);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: const ExpencesScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RoutesContants.ADD_ENTRY);
        },
      ),
    );
  }
}
