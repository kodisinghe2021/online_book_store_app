import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _animHeight = 100;
  double _animWidght = 100;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  void _updateState() {
    setState(() {
      _animHeight = screenHeight;
      _animWidght = screenWidth;
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _updateState();
    });
    // _updateState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                curve: Curves.bounceOut,
                duration: const Duration(milliseconds: 3000),
                width: _animWidght,
                height: _animHeight,
                color: ThemeData().primaryColor,
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                      duration: const Duration(milliseconds: 3000),
                      child: const Icon(Icons.book,
                          size: 150, color: Colors.white)),
                  FadeInUp(
                    duration: const Duration(milliseconds: 3000),
                    child: Text(
                      'BookLand',
                      style: GoogleFonts.eczar(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
