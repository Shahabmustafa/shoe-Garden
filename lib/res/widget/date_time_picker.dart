import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/responsive.dart';

// ignore: must_be_immutable
class DateTimePicker extends StatelessWidget {
  DateTimePicker(
      {required this.hintText,
      required this.onTap,
      required this.controller,
      super.key});
  String hintText;
  TextEditingController controller;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.07,
      width: Responsive.isDesktop(context)
          ? size.width * 0.3
          : Responsive.isTablet(context)
              ? size.width * 0.5
              : size.width * 1,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_month),
            contentPadding: EdgeInsets.only(top: 5, left: 5),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
