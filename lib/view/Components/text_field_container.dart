import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              color: kPrimaryColor.withOpacity(0.12))
        ],
        color: Colors.white,
        border: Border.all(color: kLightColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
