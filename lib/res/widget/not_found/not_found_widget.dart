import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber,
            color: Colors.black,
            size: 24,
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
