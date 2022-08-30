import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/models/user_modal.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/login/login_screen.dart';

class UserAuthController with ChangeNotifier {
//############################################################################//
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
//############################################################################//
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//############################################################################//
  String _userID = '';
//############################################################################//
  // User? get getUserData => _userData;
//############################################################################//
  late UserModal _currentUserDetails;
//############################################################################//
  UserModal? get getUserData => _currentUserDetails;
//############################################################################//
  Future<void> _createCurrentUserModal(String userId) async {
    try {
      CollectionReference collectionReference = _firestore.collection('users');
      DocumentSnapshot snapshot = await collectionReference.doc(userId).get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      _currentUserDetails = UserModal(
        userId: userId,
        name: userData['name'],
        address: userData['address'],
        nic: userData['nic'],
        contact01: userData['contact01'],
        contact02: userData['contact02'],
      );
      Logger().i('Mapped');
      Logger().w('User Modal added : ${getUserData!.name}');
    } on FirebaseException catch (e) {
      Logger().e(e.code);
    }
  }

//############################################################################//
// Task 01 User Status #################################################//
  Future<void> userStatus(BuildContext context) async {
    _mAuth.userChanges().listen((User? user) {
      if (user != null) {
        _createCurrentUserModal(user.uid);
        Navigator.pushNamed(context, ProductViewScreen.pageKey);
      } else {
        Navigator.pushNamed(context, LoginScreen.pageKey);
      }
    });
    notifyListeners();
  }

//############################################################################//
// Task 02 Creat User ##########################################//
  Future<void> createUserAndSaveDetails(
    BuildContext context,
    String email,
    String password,
    String name,
    String nic,
    String address,
    String contact01,
    String contact02,
  ) async {
    try {
      final UserCredential userCredential =
          await _mAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Logger().i('User Auth is success, with ${userCredential.user!.email}');
      if (userCredential.user != null) {
        _userID = userCredential.user!.uid;
        await _saveUserData(
          context,
          name,
          nic,
          address,
          contact01,
          contact02,
        );
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Successfull',
          text:
              'Best wishes. You have successfully registered with our application',
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'මෙම email ලිපිනය දැනටමත් ලියාපදිංචි වී ඇත',
        );
      } else if (e.code == "weak-password") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'දුර්වල මුරපදයකි. මුරපදය සදහා අවම අක්ෂර 6ක් තිබිය යුතුය.',
        );
      }
    }
    notifyListeners();
  }

//############################################################################//
// Task 03 Save User data #############################################//
  Future<void> _saveUserData(
    BuildContext context,
    String name,
    String nic,
    String address,
    String contact01,
    String contact02,
  ) async {
    Logger().w('Inside _saveUserData');
    try {
      _firestore.collection('users').doc(_userID).set({
        'name': name,
        'nic': nic,
        'address': address,
        'contact01': contact01,
        'contact02': contact02,
      }).then((value) => () {
            Logger().i('DataSetted');
            Navigator.pushNamed(context, LoginScreen.pageKey);
          });
    } on FirebaseException catch (e) {
      if (e.code == "invalid-email") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'වැරදි email ලිපිනයකි',
        );
      }

      if (e.code == "user-not-found") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'මෙම email ලිපිනය ලියාපදිංචි වී නොමැත ',
        );
      }
      if (e.code == 'wrong-password') {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'ඔබ ඇතුලත් කල මුර පදය වැරදිය',
        );
      }
      if (e.code == 'network-request-failed') {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'Connection Failed',
        );
      }
    }
    notifyListeners();
  }

//############################################################################//
// Task 04 Login user ###################################################//
  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    late UserCredential userCredential;
    try {
      await _mAuth.signInWithEmailAndPassword(email: email, password: password);
      userStatus(context);
      // if (userCredential.user != null) {
      //   _createCurrentUserModal(userCredential.user!.uid);
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'වැරදි email ලිපිනයකි',
        );
      }

      if (e.code == "user-not-found") {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'මෙම email ලිපිනය ලියාපදිංචි වී නොමැත ',
        );
      }
      if (e.code == 'wrong-password') {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'ඔබ ඇතුලත් කල මුර පදය වැරදිය',
        );
      }
      if (e.code == 'network-request-failed') {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'ERORR',
          text: 'Connection Failed',
        );
      }
    }
    notifyListeners();
  }

//############################################################################//
// Task 05 Logout user ##################################################//
  Future<void> logOutUser(BuildContext context) async {
    await _mAuth.signOut().then((value) {
      _currentUserDetails = UserModal(
        userId: '',
        name: '',
        address: '',
        nic: '',
        contact01: '',
        contact02: '',
      );
      if (_currentUserDetails.userId.isEmpty) {
        Navigator.pushNamed(context, LoginScreen.pageKey);
      }
    });
    notifyListeners();
  }
//############################################################################//
}
