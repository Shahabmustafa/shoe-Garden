import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/responsive.dart';

class CustomTableCell extends StatelessWidget {
  final String? text;
  final Color textColor;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;

  const CustomTableCell({
    super.key,
    this.text,
    this.height,
    this.width,
    required this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text.toString(),
          textAlign: TextAlign.start,
          style: GoogleFonts.lora(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: Responsive.isDesktop(context)
                ? 14
                : Responsive.isTablet(context)
                    ? 13
                    : Responsive.isMobile(context)
                        ? 12
                        : 10,
          ),
        ),
      ),
    );
  }
}
