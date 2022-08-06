import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/user_provider.dart';
import 'package:online_book_store_app/screens/home_screens/product_view_screen.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    navigateToStPage();
    super.initState();
  }

// movie to login screen after .. seconds
  void navigateToStPage() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Logger().i('~~~~~~~~~~~~~~~~~~~~ listen Startt~~~~~~~~~~~~~~~~~~~');
      Provider.of<UserProvider>(context, listen: false).userStatus(context);
      Logger().i('~~~~~~~~~~~~~~~~~~~~ listen End   ~~~~~~~~~~~~~~~~~~~');
      // isUserAlreaduLogged
      //     ? Navigator.popAndPushNamed(context, LoginScreen.pageKey)
      //     : Navigator.popAndPushNamed(context, ProductViewScreen.pageKey);
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
                duration: const Duration(milliseconds: 3000),
                child: const Icon(Icons.book,
                    size: 150, color: ConstantValues.primaryColor)),
            FadeInUp(
              duration: const Duration(milliseconds: 3000),
              child: Text(
                'BookLand',
                style: GoogleFonts.eczar(
                  color: ConstantValues.primaryColor,
                  fontSize: 40,
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
