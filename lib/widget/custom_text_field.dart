import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/constant.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.screenSize,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.isObsecure = false,
    this.suffixIcon,
  }) : super(key: key);

  final Size screenSize;
  final String label;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final TextEditingController controller;
  bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.8,
      child: TextField(
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          label: Text(label),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: ConstantValues.primaryColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Color(0xFFD9F8C4),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSinhalaTextField extends StatelessWidget {
  CustomSinhalaTextField({
    Key? key,
    required this.screenSize,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.isObsecure = false,
    this.suffixIcon,
  }) : super(key: key);
  final Size screenSize;
  final String label;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final TextEditingController controller;
  bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.8,
      child: TextField(
        style: GoogleFonts.notoSerifSinhala(),
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          label: Text(label),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: ConstantValues.primaryColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Color(0xFFD9F8C4),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
