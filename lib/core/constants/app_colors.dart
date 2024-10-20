import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static Color cPrimaryBlue = const Color(0xff3369ff);
  static Color cWhite = const Color(0xFFFFFFFF);
  static Color cGrey = const Color(0xFFD8D8D8);
  static Color cSenderBubbleCar = const Color(0xFFEEEEEE);

  static Color cBlack = const Color(0xff3f3f3f);
  static Color cGreen = const Color(0xff3abf38);
  final cRegular = GoogleFonts.nunito(
    fontWeight: FontWeight.w500,
  );

  static final cSemiBold = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
  );

  static final cBold = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
  );
  static final cLargeBold = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontSize: 50,
  );
}
