import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DotText extends StatelessWidget {
  DotText({required this.title, super.key});
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
