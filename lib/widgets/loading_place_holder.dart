import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/loading_item.dart';

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * .6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (BuildContext ctx, int index) {
            return const LoadingItem();
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
