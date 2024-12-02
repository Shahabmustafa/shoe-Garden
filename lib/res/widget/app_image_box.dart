import 'package:flutter/material.dart';

import '../responsive.dart';

// ignore: must_be_immutable
class AppImageBox extends StatelessWidget {
  AppImageBox({
    required this.title,
    required this.onTap,
    required this.decoration,
    super.key,
  });
  String title;
  VoidCallback onTap;
  Decoration decoration;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.1,
        width: Responsive.isDesktop(context) ? 300 : 400,
        decoration: decoration,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
