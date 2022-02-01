

import 'package:flutter/material.dart';
import 'package:my_expenses/pages/expenses.dart';


class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({ Key? key ,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(title),),
      body:const ExpencesScreen(),
    );
  }
}