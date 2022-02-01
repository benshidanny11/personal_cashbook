import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/upper_info.dart';

class ExpencesScreen extends StatelessWidget {
  const ExpencesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child:Column(
        children:const [UpperData()],
      ),
    );
  }
}