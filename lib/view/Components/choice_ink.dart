import 'package:flutter/material.dart';

class ChoiceInk extends StatelessWidget {
  const ChoiceInk({Key? key, required this.iHeight, required this.iWidth, required this.iHorizontalMargin, required this.iVerticalMargin}) : super(key: key);
final double iHeight;
final double iWidth;
final double iHorizontalMargin;
final double iVerticalMargin;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          print('tapped');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          margin: EdgeInsets.symmetric(horizontal: iHorizontalMargin,vertical: iVerticalMargin),
          height: iHeight,
           width: iWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.transparent.withOpacity(0.1)),
          child:


          const Center(child: Text("الأولى")),


        ),
      ),
    );
  }
}
