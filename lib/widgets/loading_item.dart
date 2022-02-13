import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200] as Color,
                  blurRadius: 3,
                  spreadRadius: 1)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10,
                  width: 180,
                  color: Colors.grey[100],
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey[100],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: 230,
              color: Colors.grey[100],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: 100,
              color: Colors.grey[100],
            )
          ],
        ));
  }
}
