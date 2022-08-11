import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_future_builder.dart';
import 'package:online_book_store_app/widget/enums.dart';

class Grade04Screen extends StatefulWidget {
  const Grade04Screen({Key? key}) : super(key: key);

  @override
  State<Grade04Screen> createState() => _Grade04ScreenState();
}

class _Grade04ScreenState extends State<Grade04Screen> {
// ~~~~~~~~~~~~~~~~~~~~~~  instance of the firestore ~~~~~~~~~~~~~~~~~~~~~//
  FirebaseFirestore firestore = FirebaseFirestore.instance;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomFutureBuilder(gradeEnum: EnumVariables.grade_04), //future bu,
    );
  }
}
