import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFont{
  static TextStyle fontTitleCard(Color color, double fontSize){
    return GoogleFonts.gothicA1(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.01,
        wordSpacing: 0.001
    );
  }
}