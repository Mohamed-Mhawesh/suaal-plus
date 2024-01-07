import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final List<Widget> choices;

  const Options({Key? key, required this.choices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: choices,
      ),
    );
  }
}
