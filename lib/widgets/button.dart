import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onButtonClick;
  const Button({Key? key, required this.text, required this.onButtonClick,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(20),
          
          boxShadow: [
            BoxShadow(
                color: Colors.indigo[300] as Color,
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: TextButton(
        child: Text(text,style: const TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 14),),
        onPressed: () {
          onButtonClick();
        },
      ),
    );
  }
}
