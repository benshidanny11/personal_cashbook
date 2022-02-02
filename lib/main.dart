import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/pages/addentry.dart';
import 'package:my_expenses/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My expences',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: 'poppins'
      ),
      home: const HomeScreen(title: "My expences",),
      routes: {
        RoutesContants.ADD_ENTRY:(contex)=> AddEntry(),
      },
    );
  }
}

