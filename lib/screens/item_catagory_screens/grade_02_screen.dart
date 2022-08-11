import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_future_builder.dart';
import 'package:online_book_store_app/widget/enums.dart';

class Grade02Screen extends StatefulWidget {
  const Grade02Screen({Key? key}) : super(key: key);

  @override
  State<Grade02Screen> createState() => _Grade02ScreenState();
}

class _Grade02ScreenState extends State<Grade02Screen> {
  @override
  Widget build(BuildContext context) {
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final screenSize = MediaQuery.of(context).size;
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    return Scaffold(
      body: CustomFutureBuilder(gradeEnum: EnumVariables.grade_02), //future bu,
    );
  }
}
