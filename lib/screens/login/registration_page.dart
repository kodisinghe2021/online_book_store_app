import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/controllers/validations.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/design_parts.dart';
import 'package:online_book_store_app/widget/headings.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String pageKey = '/register-screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
//###########################################################################//
  final TextEditingController _name = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _contact01 = TextEditingController();
  final TextEditingController _contact02 = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  //###########################################################################//
  final ValidationHelper _validations = ValidationHelper();
  //###########################################################################//
  bool _isLoading = false;
  bool _pwVisibility = false;
//###########################################################################//
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 20,
                right: 20,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Already Have Acount?Login here')),
              ),
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: TopBanner(
                  screenSize: screenSize,
                  heightMinimizingValue: 0.15,
                ),
              ),
              //Main heading Text
              Positioned(
                left: screenSize.width * 0.11,
                top: screenSize.height * 0.05,
                child: Heading01(
                  fontSize: 40,
                  text: 'Registration',
                ),
              ),

              //Main heading Icon
              Positioned(
                right: screenSize.width * 0.11,
                top: screenSize.height * 0.05,
                child: const Icon(
                  Icons.person_add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 180),
//############################################################################//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _name,
                        label: 'Name',
                        prefixIcon: const Icon(Icons.person_add_outlined),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _nic,
                        label: 'NIC',
                        prefixIcon: const Icon(Icons.confirmation_num_outlined),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _address,
                        label: 'Address',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        hintText: '0771234567',
                        screenSize: screenSize,
                        controller: _contact01,
                        label: 'Cantact 01',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _contact02,
                        label: 'Cantact 02',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _email,
                        label: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      CustomTextField(
                        isObsecure: !_pwVisibility,
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
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 10),
//############################################################################//
                      Positioned(
                        bottom: screenSize.height * 0.3,
                        left:
                            (screenSize.width - screenSize.width * 0.69) * 0.5,
                        child: SizedBox(
                          width: screenSize.width * 0.69,
                          height: screenSize.height * 0.056,
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomElevatedButton(
                                  text: 'Register',
                                  onTap: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_validations.fieldsEmptyChecker(
                                          _email.text,
                                          _password.text,
                                          _name.text,
                                          _address.text,
                                          _nic.text,
                                          _contact01.text,
                                          _contact02.text,
                                        ) &&
                                        _validations.emailValidation(
                                          _email.text,
                                          _password.text,
                                        ) &&
                                        _validations.mobileNumerValidation(
                                          _contact01.text,
                                          _contact02.text,
                                        )) {
                                      await Provider.of<UserAuthController>(
                                              context,
                                              listen: false)
                                          .createUserAndSaveDetails(
                                        context,
                                        _email.text.trim(),
                                        _password.text.trim(),
                                        _name.text.trim(),
                                        _nic.text.trim(),
                                        _address.text.trim(),
                                        _contact01.text.trim(),
                                        _contact02.text.trim(),
                                      );
                                    } else if (_validations.errorCode == 3) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        title: 'හිස්වූ පෙළ ක්ෂේත්ර ඇත',
                                        text: 'සියලුම පෙළ ක්ෂේත්ර පිරවිය යුතුය',
                                      );
                                    } else if (_validations.errorCode == 1) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        title: "ඔබ ඇතුල්කල email ලිපිනය වැරදිය",
                                        text:
                                            "email ලිපිනය තුල '@' සහ '.' අඩංගු විය යුතුය.",
                                      );
                                    } else if (_validations.errorCode == 2) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        title: "ඔබ ඇතුල්කල දුරකථන අංකය වැරදිය",
                                        text:
                                            "දුරකථන අංකය සදහා අංක දහයක් තිබිය යුතුය.",
                                      );
                                    }

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
