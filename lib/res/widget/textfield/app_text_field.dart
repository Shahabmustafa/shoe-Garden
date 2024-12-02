import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../responsive.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  AppTextField(
      {required this.labelText,
      this.onChanged,
      this.onFieldSubmitted,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.enabled = true,
      this.search = false,
      this.validator,
      this.obscureText = false,
      this.isDense = false,
      this.colors = const Color(0xff13132a),
      this.type = TextInputType.emailAddress,
        this.onlyNumerical = false,
      super.key});

  String labelText;
  TextEditingController? controller;
  bool enabled;
  bool search;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  bool obscureText;
  bool isDense;
  TextInputType type;
  Color colors;
  final void Function(String)? onFieldSubmitted;
  bool onlyNumerical;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.07,
      width: Responsive.isDesktop(context)
          ? size.width * 0.3
          : Responsive.isTablet(context)
              ? size.width * 0.5
              : size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: type,
        cursorHeight: 12,
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        cursorColor: Color(0xff13132a),
        style: GoogleFonts.lora(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colors,
        ),
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: onlyNumerical ? <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ] : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 1, left: 10),
          labelText: labelText,
          isDense: isDense,
          hintStyle: GoogleFonts.lora(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
