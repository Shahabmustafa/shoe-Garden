import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive.dart';

// ignore: must_be_immutable
class AppExportButton extends StatelessWidget {
  AppExportButton({required this.icons, this.onTap, super.key});

  IconData icons;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.05,
        width: Responsive.isDesktop(context) ? 120 : 90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff13132a),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons,
                color: Colors.white,
                size: Responsive.isDesktop(context)
                    ? 20
                    : Responsive.isTablet(context)
                        ? 18
                        : Responsive.isMobile(context)
                            ? 16
                            : 14),
            // const SizedBox(
            //   width: 5,
            // ),
            Text(
              "Export",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: Responsive.isDesktop(context)
                    ? 14
                    : Responsive.isTablet(context)
                        ? 13
                        : Responsive.isMobile(context)
                            ? 12
                            : 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
