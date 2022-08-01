import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String pageKey = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _unLogin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            //top curved Container
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: screenSize.width,
            //     height: screenSize.height * 0.3,
            //     decoration: const BoxDecoration(
            //       color: ConstantValues.primaryColor,
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(100),
            //           bottomRight: Radius.circular(100)),
            //     ),
            //   ),
            // ),

            // bottom wave
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: screenSize.height * 0.4,
                width: screenSize.width,
                child: Image.asset(
                  'assets/images/btmwave.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //Main heading Text
            Positioned(
              left: screenSize.width * 0.11,
              top: screenSize.height * 0.05,
              child: Text(
                'LOGIN',
                style: GoogleFonts.mouseMemoirs(
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),
            ),

            //Main heading Icon
            Positioned(
              right: screenSize.width * 0.11,
              top: screenSize.height * 0.05,
              child: const Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              ),
            ),
            //center container
            Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 80),
                  width: screenSize.width * 0.95,
                  height: screenSize.height * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ConstantValues.primaryColor, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //username field
                      SizedBox(
                        width: screenSize.width * 0.8,
                        child: TextField(
                          controller: _unLogin,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email_outlined),
                            label: Text('Email'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: ConstantValues.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFD9F8C4),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      // password field
                      SizedBox(
                        width: screenSize.width * 0.8,
                        child: TextField(
                          controller: _unLogin,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.security_sharp),
                            label: Text('Password'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: ConstantValues.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFD9F8C4),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
