import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatToMatchPage();
    super.initState();
  }

  Future<void> navigatToMatchPage() async {
    //  await checkUser();
    Future.delayed(const Duration(seconds: 3), () async {
      await Provider.of<UserAuthController>(context, listen: false)
          .userStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 2000),
              child: const Icon(Icons.book,
                  size: 90, color: ConstantValues.primaryColor),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 2000),
              child: Text(
                'BookLand',
                style: GoogleFonts.eczar(
                  color: ConstantValues.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
