import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading01 extends StatelessWidget {
  Heading01({
    Key? key,
    required this.text,
    this.fontSize = 90.0,
  }) : super(key: key);
  final String text;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mouseMemoirs(
        letterSpacing: 3.0,
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }
}
