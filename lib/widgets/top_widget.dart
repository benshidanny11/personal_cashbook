import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  final String actionName;

  const TopWidget({Key? key, required this.actionName,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100)),
          boxShadow: [
            BoxShadow(
                color: Colors.indigo[300] as Color,
                blurRadius: 20,
                spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.asset('images/applogo_trans.png',width: 100,height: 100,),
          const SizedBox(
            height: 10,
          ),
          Text(
            actionName,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
