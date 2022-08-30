import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/controllers/validations.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/login/registration_page.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/design_parts.dart';
import 'package:online_book_store_app/widget/headings.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String pageKey = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//############################################################################//
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
//############################################################################//
  final ValidationHelper _validations = ValidationHelper();
  //###########################################################################//
  bool _pwVisibility = true;
  bool _isLoading = false;
//############################################################################//
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
                Positioned(
                  bottom: screenSize.height * 0.5,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    screenSize: screenSize,
                    controller: _email,
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
                    controller: _password,
                    label: 'Password',
                    prefixIcon: const Icon(Icons.security_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _pwVisibility = !_pwVisibility;
                        });
                      },
                      icon: _pwVisibility
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),

//############################################################################//
                Positioned(
                  bottom: screenSize.height * 0.34,
                  left: (screenSize.width - screenSize.width * 0.69) * 0.5,
                  child: SizedBox(
                    width: screenSize.width * 0.69,
                    height: screenSize.height * 0.056,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                            text: 'Login',
                            onTap: () async {
                              if (emptyChecker()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Provider.of<UserAuthController>(context,
                                        listen: false)
                                    .loginUser(
                                        context, _email.text, _password.text);
                                setState(() {
                                  _isLoading = false;
                                });
                                // if (userData.user != null) {
                                //   Navigator.pushReplacementNamed(
                                //       context, ProductViewScreen.pageKey);
                                // }
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: 'හිස්වූ පෙළ ක්ෂේත්ර ඇත',
                                  text: 'සියලුම පෙළ ක්ෂේත්ර පිරවිය යුතුය',
                                );
                              }
                            },
                          ),
                  ),
                ),
//############################################################################//
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
//############################################################################//
                //link to reset password
                Positioned(
                  bottom: screenSize.height * 0.17,
                  right: screenSize.width * 0.07,
                  child: CustomTextButton(
                    text: "Forgot Password",
                    onTap: () {},
                  ),
                ),

//############################################################################//
                Positioned(
                  left: 20,
                  bottom: 90,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, ProductViewScreen.pageKey);
                        },
                        child: Text(
                          'Continue as a guest',
                          style: GoogleFonts.acme(
                              fontSize: 20, color: Colors.amber),
                        ),
                      ),
                      const Icon(Icons.arrow_circle_right_sharp)
                    ],
                  ),
                ),
//############################################################################//
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToMainPage(BuildContext context) =>
      Navigator.pushReplacementNamed(context, ProductViewScreen.pageKey);

  bool emptyChecker() {
    bool isValid = false;
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      isValid = true;
    }
    return isValid;
  }
}
