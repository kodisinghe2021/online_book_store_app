import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const pageKey = '/profile-screen';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.greenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Under Maintain',
              style: GoogleFonts.alef(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
