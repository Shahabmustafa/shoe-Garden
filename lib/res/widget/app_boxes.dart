import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/responsive.dart';

// ignore: must_be_immutable
class AppBoxes extends StatelessWidget {
  AppBoxes(
      {required this.title,
      required this.amount,
      this.imageUrl,
      this.width,
      this.height,
      super.key});
  String title;
  String amount;
  String? imageUrl;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.2,
            color: Colors.grey.shade300,
            offset: const Offset(
              0.5,
              0.5,
            ),
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: MediaQuery.sizeOf(context).width > 600
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    imageUrl.toString(),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.w700,
                        fontSize: Responsive.isDesktop(context)
                            ? 18
                            : Responsive.isTablet(context)
                                ? 14
                                : Responsive.isMobile(context)
                                    ? 10
                                    : null,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      amount,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.isDesktop(context)
                            ? 18
                            : Responsive.isTablet(context)
                                ? 14
                                : Responsive.isMobile(context)
                                    ? 10
                                    : null,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(imageUrl.toString(),
                      height: 30, width: 30, fit: BoxFit.cover),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 370 ? 12 : 10,
                      ),
                    ),
                    Text(
                      amount,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
