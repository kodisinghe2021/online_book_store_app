import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/design_parts.dart';
import 'package:online_book_store_app/widget/headings.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String pageKey = '/register-screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameSign = TextEditingController();
  final TextEditingController _mobileSign = TextEditingController();
  final TextEditingController _unSign = TextEditingController();
  final TextEditingController _pwSign = TextEditingController();

  final FirebaseAuth mAuth = FirebaseAuth.instance;
  bool _pwVisibility = false;

  bool _isValid() {
    bool validationStatus = false;

    if (_pwSign.text.isEmpty) {
      Logger().w('Empty Password');
      return false;
    }
    if (_unSign.text.isEmpty) {
      Logger().w('Empty Username');
        return false;
    }
    return validationStatus;
  }

  Future<void> _signinUser() async {
    // print(
    //     "Name:- ${_nameSign.text} mobile:- ${_mobileSign.text} un:- ${_unSign.text} pw:- ${_pwSign.text}");
    try {
      UserCredential userCredential = await mAuth.createUserWithEmailAndPassword(
          email: _unSign.text, password: _pwSign.text);
      if (userCredential.user!.uid != null) {
        Logger().i('Registration success');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                    duration: const Duration(milliseconds: 2000),
                    child: TopBanner(
                        screenSize: screenSize, heightMinimizingValue: 0.2)),

                // bottom wave
                FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: BottomWave(screenSize: screenSize)),

                //Main heading Text
                Positioned(
                  left: screenSize.width * 0.11,
                  top: screenSize.height * 0.05,
                  child: Heading01(
                    fontSize: 50,
                    text: 'Registration',
                  ),
                ),

                //Main heading Icon
                Positioned(
                  right: screenSize.width * 0.11,
                  top: screenSize.height * 0.05,
                  child: const Icon(
                    Icons.person_add,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: screenSize.height * 0.64,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    screenSize: screenSize,
                    controller: _nameSign,
                    label: 'Name',
                    prefixIcon: const Icon(Icons.person_add_outlined),
                  ),
                ),
                Positioned(
                  bottom: screenSize.height * 0.56,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    screenSize: screenSize,
                    controller: _mobileSign,
                    label: 'Mobile',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                //center container
                Positioned(
                  bottom: screenSize.height * 0.48,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    screenSize: screenSize,
                    controller: _unSign,
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),

                // password field
                Positioned(
                  bottom: screenSize.height * 0.4,
                  left: (screenSize.width - screenSize.width * 0.8) * 0.5,
                  child: CustomTextField(
                    isObsecure: _pwVisibility,
                    screenSize: screenSize,
                    controller: _pwSign,
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
                  bottom: screenSize.height * 0.3,
                  left: (screenSize.width - screenSize.width * 0.69) * 0.5,
                  child: SizedBox(
                    width: screenSize.width * 0.69,
                    height: screenSize.height * 0.056,
                    child: CustomElevatedButton(
                      text: 'Register',
                      onTap: () {
                        _signinUser();
                      },
                    ),
                  ),
                ),

                //link to registration page
                Positioned(
                  bottom: screenSize.height * 0.2,
                  width: screenSize.width,
                  child: CustomTextButton(
                    text: "Already have an account? Login here",
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.pageKey);
                    },
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
