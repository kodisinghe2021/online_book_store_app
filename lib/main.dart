import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/screens/login_screen/registration_page.dart';
import 'package:online_book_store_app/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.pageKey: (context) => const LoginScreen(),
        RegistrationScreen.pageKey: (context) => const RegistrationScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstantValues.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(color: Color(0xFF06113C)),
      ),
      //theme stup
      title: 'title',
      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}
