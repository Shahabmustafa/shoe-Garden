import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 400;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1100 &&
      MediaQuery.sizeOf(context).width > 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  ///height screen

  static bool isMobileHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height > 740 &&
      MediaQuery.sizeOf(context).height < 900;

  static bool isTabletHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height > 900;

  static bool isDesktopHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height < 740;
}
