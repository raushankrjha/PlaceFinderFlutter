import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFFFF6347);
  static const Color loginGradientEnd = const Color(0xFFFF1493);



  static const Color signupGradientStart = const Color(0xFFFF5E3A);
  static const Color signupGradientEnd = const Color(0xFFFF9500);

  static const Color thirdGradientStart = const Color(0xFFE76503);
  static const Color thirdGradientEnd = const Color(0xFFFED669);

  static const Color firstGradientStart = const Color(0xFF4CB8C4);
  static const Color firstGradientEnd = const Color(0xFF38EF7D);

  static const Color locationGradientStart = const Color(0xFF5B86E5);
  static const Color locationGradientEnd = const Color(0xFF36D1DC);

  static const Color headerGradientStart = const Color(0xFF4CB8C4);
  static const Color headerGradientEnd = const Color(0xFF3CD3AD);

  static const Color fourGradientStart = const Color(0xFF2C3E50);
  static const Color fourGradientEnd = const Color(0xFFBDC3C7);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [2.0, 1.0],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );
  static const primaryGradient1 = const LinearGradient(
    colors: const [signupGradientStart, signupGradientEnd],
    stops: const [2.0, 1.0],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );
}