import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';

void main() {
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

      home: const LoginScreen(),
    );
  }
}
