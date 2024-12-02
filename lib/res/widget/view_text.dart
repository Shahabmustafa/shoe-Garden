import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewText extends StatelessWidget {
  const ViewText({required this.title, required this.subTitle, super.key});
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subTitle,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
