import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/controllers/user_auth_controller.dart';
import 'package:online_book_store_app/screens/admin/admin_dashboard.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/login/registration_page.dart';
import 'package:online_book_store_app/utils/alert_support.dart';
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
  final TextEditingController _emailLogin = TextEditingController();
  final TextEditingController _passwordLogin = TextEditingController();

  bool _pwVisibility = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserAuthController userAuthController = UserAuthController();
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
                    controller: _emailLogin,
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
                    controller: _passwordLogin,
                    label: 'Password',
                    prefixIcon: const Icon(Icons.security_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _pwVisibility = !_pwVisibility;
                        });
                      },
                      icon: !_pwVisibility
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
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                            text: 'Login',
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (_emailLogin.text.isNotEmpty &&
                                  _passwordLogin.text.isNotEmpty) {
                                bool loginSuccess =
                                    await userAuthController.loginUser(
                                  context,
                                  _emailLogin.text,
                                  _passwordLogin.text,
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                                if (loginSuccess) {
                                  Navigator.popAndPushNamed(
                                      context, ProductViewScreen.pageKey);
                                }
                              } else {
                                AlertSupprt.showDialogBox(
                                    context,
                                    CoolAlertType.warning,
                                    'Empty Fields',
                                    'Fields Cannot be empty', () {
                                  Navigator.pop(context);
                                });
                              }
                            },
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
                TextButton(
                  onPressed: () async {
                    if (_emailLogin.text == "fxkodisinghe@gmail.com") {
                      bool isSuccess = await UserAuthController().loginUser(
                          context, _emailLogin.text, _passwordLogin.text);
                      if (isSuccess) {
                        Navigator.pushNamed(context, AdminDashBoard.pageKey);
                      }
                    }
                    {}
                  },
                  child: Text(
                    'NKSoftTech',
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5)),
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
