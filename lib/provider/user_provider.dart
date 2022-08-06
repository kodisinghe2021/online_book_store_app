import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/screens/home_screens/product_view_screen.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/utils/alert_support.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _uid = '';
  String _email = '';
  String _name = '';
  String _mobile = '';

// providing name
  String get userName => _name;

// function to clear all data
  void clearUserData() {
    _uid = '';
    _email = '';
    _name = '';
    _mobile = '';
  }

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
      await _mAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _gettingUserData(context, value.user!.uid, email));

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertSupprt.showDialogBox(
            context, CoolAlertType.error, 'ERROR', 'Invalid email', () {
          Navigator.pop(context);
        });
      } else if (e.code == 'wrong-password') {
        AlertSupprt.showDialogBox(
            context, CoolAlertType.error, 'ERROR', 'Invalid Password', () {
          Navigator.pop(context);
        });
      } else {
        AlertSupprt.showDialogBox(
            context, CoolAlertType.error, 'ERROR', 'Somthing Went Wrong', () {
          Navigator.pop(context);
        });
      }
    }
    notifyListeners();
  }

  Future<void> _gettingUserData(
      BuildContext context, String uID, String email) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uID).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      _uid = uID;
      _email = email;
      _name = data['name'];
      _mobile = data['mobile'];
    } on FirebaseAuthException catch (e) {
      AlertSupprt.showDialogBox(context, CoolAlertType.error, 'ERROR',
          'Somthing Went Wrong ${e.code}', () {
        Navigator.pop(context);
      });
    }
  }

  // current user status, in this method they will
  //check whether the user is currently sign in or sign out.
  // if user signout this method will listen

  Future<void> userStatus(BuildContext context) async {
    _mAuth.userChanges().listen((User? user) {
      if (user == null) {
        Navigator.popAndPushNamed(context, LoginScreen.pageKey);
      } else {
        _gettingUserData(context, user.uid, user.email.toString()).then(
            (value) => Navigator.popAndPushNamed(context, ProductViewScreen.pageKey));
      }
    });
    notifyListeners();
  }

  // Signout user and clear all user data from local memory

  Future<void> logOutUser() async {
    await _mAuth.signOut().then((value) => clearUserData());
    Logger().i(
        'Current user is Signout now: user ID: $_uid -- email: $_email  --  name:  $_name  --  mobile:  $_mobile');
    notifyListeners();
  }
}
