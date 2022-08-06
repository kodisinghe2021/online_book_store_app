import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/utils/alert_support.dart';

class UtilFunctions {
// Firebase Auth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;

// Firebase FireStore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // static Size getScreenSize(BuildContext context) =>
  //     MediaQuery.of(context).size;

//Validate data from frontend

  // check fields are empty or not
  Future <void> validateAndSigninStoreUser(
    BuildContext context,
    String name,
    String mobile,
    String email,
    String password,
  ) async{
    if (email == "" && password == "" && name == "" && mobile == "") {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.warning,
        'EMPTY',
        'Fields cannot be empty',
        () {
          Navigator.pop(context);
        },
      );
    } else if (email == "") {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.warning,
        'EMPTY',
        'Email cannot be empty',
        () {
          Navigator.pop(context);
        },
      );
    } else if (password == "") {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.warning,
        'EMPTY',
        'Password cannot be empty',
        () {
          Navigator.pop(context);
        },
      );
    } else if (name == "") {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.warning,
        'EMPTY',
        'Name cannot be empty',
        () {
          Navigator.pop(context);
        },
      );
    } else if (mobile == "") {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.warning,
        'EMPTY',
        'Mobile cannot be empty',
        () {
          Navigator.pop(context);
        },
      );
    } else {
      if (mobile.length != 10 && !mobile.startsWith('0')) {
        AlertSupprt.showDialogBox(
          context,
          CoolAlertType.warning,
          'INVALID',
          'mobile should have 10 numbers and Start with 0',
          () {
            Navigator.pop(context);
          },
        );
      } else if (password.length < 6) {
        AlertSupprt.showDialogBox(
          context,
          CoolAlertType.warning,
          'INVALID',
          'Password must have at least 6 characters.',
          () {
            Navigator.pop(context);
          },
        );
      } else if (!email.contains('@')) {
        AlertSupprt.showDialogBox(
          context,
          CoolAlertType.warning,
          'INVALID',
          "Email address must contain '@'",
          () {
            Navigator.pop(context);
          },
        );
      } else {
        Logger().w(
            "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ REGISTRATION SUCCESS ~~~~~~~~~~~~~~~~~");
         _signinUser(context, name, mobile, email, password);
      }
    }
  }

// Signin user with firebase Authonticate
  Future<void> _signinUser(
    BuildContext context,
    String name,
    String mobile,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _mAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String newUserEmail = userCredential.user!.email.toString();
      String uID = userCredential.user!.uid;
      Logger().i(
          '~~~~~~~~~~~~~ Succesfuly Signin with  $newUserEmail  ~~~~~~~~~~~~~~~~~~~');

      _storeData(context, uID, name, mobile, newUserEmail);

      // if there is an errors then execute below section
    } on FirebaseAuthException catch (e) {
      AlertSupprt.showDialogBox(
        context,
        CoolAlertType.error,
        'ERROR',
        "ERROR Code :- ${e.code}",
        () {
          Navigator.pop(context);
        },
      );
    }
  }

//Store user data in Firestore
  Future<void> _storeData(
    BuildContext context,
    String uID,
    String name,
    String mobile,
    String email,
  ) async {
    try {
      _firestore.collection('users').doc(uID).set({
        'uid': uID,
        'name': name,
        'mobile': mobile,
      }).then(
        (value) => AlertSupprt.showDialogBox(
          context,
          CoolAlertType.success,
          'Congratulations',
          'You have registered correctly',
          () {
            Navigator.popAndPushNamed(
              context,
              LoginScreen.pageKey,
              arguments: name,
            );
          },
        ),
      );
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
    // _firestore.collection('users').doc(documentReference.id).
  }
}
