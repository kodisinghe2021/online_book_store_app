import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/login_screen/registration_page.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/design_parts.dart';
import 'package:online_book_store_app/widget/headings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String pageKey = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _unLogin = TextEditingController();
  final TextEditingController _pwLogin = TextEditingController();
  bool _pwVisibility = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  color: const Color(0xFFFEFBF6),
                ),
                // top curved Container
                FadeInDown(
                    from: 200,
                    duration: const Duration(milliseconds: 2000),
                    child: TopBanner(screenSize: screenSize)),

                // bottom wave
                FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: BottomWave(screenSize: screenSize)),

                //Main heading Text
                Positioned(
                  left: screenSize.width * 0.11,
                  top: screenSize.height * 0.05,
                  child: Heading01(
                    text: 'LOGIN',
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
                Positioned(
                  bottom: screenSize.height * 0.5,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    screenSize: screenSize,
                    controller: _unLogin,
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),

                // password field
                Positioned(
                  bottom: screenSize.height * 0.42,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    isObsecure: _pwVisibility,
                    screenSize: screenSize,
                    controller: _pwLogin,
                    label: 'Password',
                    prefixIcon: const Icon(Icons.security_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _pwVisibility = !_pwVisibility;
                        });
                      },
                      icon: _pwVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),

                //Login button
                Positioned(
                  bottom: screenSize.height * 0.34,
                  left: (screenSize.width - screenSize.width * 0.69) * 0.5,
                  child: SizedBox(
                    width: screenSize.width * 0.69,
                    height: screenSize.height * 0.056,
                    child: CustomElevatedButton(
                      text: 'Login',
                      onTap: () {},
                    ),
                  ),
                ),

                //link to registration page
                Positioned(
                  bottom: screenSize.height * 0.23,
                  width: screenSize.width,
                  child: CustomTextButton(
                    text: "haven't account? Register here",
                    onTap: () {
                      Navigator.pushNamed(context, RegistrationScreen.pageKey);
                    },
                  ),
                ),

                //link to reset password
                Positioned(
                  bottom: screenSize.height * 0.17,
                  right: screenSize.width * 0.07,
                  child: CustomTextButton(
                    text: "Forgot Password",
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
