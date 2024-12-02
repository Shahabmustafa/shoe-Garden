import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';

import '../responsive.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {required this.title,
      this.loading = false,
      required this.onTap,
      this.height,
      this.width,
      this.changeValue = false,
      super.key});
  String? title;
  bool loading;
  VoidCallback onTap;
  double? height;
  double? width;
  bool changeValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? size.height * 0.07,
        width: Responsive.isDesktop(context)
            ? size.width * 0.3
            : Responsive.isTablet(context)
                ? size.width * 0.5
                : size.width * 1,
        decoration: BoxDecoration(
          color: changeValue ? Colors.white : Color(0xff13132a),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: changeValue ? Color(0xff13132a) : Colors.white,
          ),
        ),
        child: loading
            ? Center(child: CircularIndicator.waveSpinkitButton)
            : Center(
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: changeValue ? Color(0xff13132a) : Colors.white,
                  ),
                ),
              ),
      ),
    );
    // :
    // GestureDetector(
    //       onTap: onTap,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10),
    //         child: Container(
    //           height: height ?? size.height * 0.07,
    //           width: width ?? size.width * 1,
    //           decoration: BoxDecoration(
    //             color: Color(0xff13132a),
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //           child: loading ?
    //           Center(child: CircularProgressIndicator()) :
    //           Center(child: Text(
    //             '$title',
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white,
    //             ),
    //           ),
    //           ),
    //         ),
    //       ),
    //     );
  }
}
