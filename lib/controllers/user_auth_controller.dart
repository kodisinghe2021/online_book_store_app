import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/utils/alert_support.dart';

class UserAuthController {
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

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool isLoginSuccess = false;
    try {
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
      await _mAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isLoginSuccess = true;
        return _gettingUserData(value.user!.uid, email);
      });

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertSupprt.showDialogBox(
            context, CoolAlertType.error, 'ERROR', 'This email not registered',
            () {
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
    return isLoginSuccess;
  }

  Future<void> _gettingUserData(String uID, String email) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uID).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      _uid = uID;
      _email = email;
      _name = data['name'];
      _mobile = data['mobile'];
      Logger().i(
          '~~~~~~~~~~~~~ $_uid  $_email  $_name   $_mobile ~~~~~~~~~~~~~~~~~~~~~~~~~~');
    } on FirebaseAuthException catch (e) {
      Logger().e('~~~~~~~~~~~~~${e.code} ~~~~~~~~~~~~~~~~~~~');
    }
  }

//                              User status checker
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  Future<bool> userStatus() async {
    bool userisLogged = false;
    _mAuth.userChanges().listen((User? user) {
      if (user == null) {
        userisLogged = false;
      } else {
        userisLogged = true;
        _gettingUserData(user.uid, user.email.toString());
      }
    });
    return userisLogged;
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  Future<void> logOutUser() async {
    await _mAuth.signOut().then((value) => clearUserData());
    Logger().i(
        'Current user is Signout now: user ID: $_uid -- email: $_email  --  name:  $_name  --  mobile:  $_mobile');
  }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
}
