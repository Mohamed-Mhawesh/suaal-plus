import 'package:flutter/material.dart';

import 'package:suaal_plus/theme/constants.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBox({
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              color: kPrimaryColor.withOpacity(0.12))
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: kPrimaryColor.withOpacity(0.4),
          ),
          hintText: "ابحث هنا",
          hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.4)),
        ),
      ),
    );
  }
}
