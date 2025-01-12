import 'package:flutter/material.dart';

class AppResponsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTab(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 600 &&
        MediaQuery.sizeOf(context).width < 900;
  }

  static bool isWide(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 900;
  }
}
