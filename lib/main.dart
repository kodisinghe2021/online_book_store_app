import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4267B2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      //theme stup
      title: 'title',
      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}
