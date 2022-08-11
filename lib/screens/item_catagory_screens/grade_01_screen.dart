import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_future_builder.dart';
import 'package:online_book_store_app/widget/enums.dart';

class Grade01Screen extends StatefulWidget {
  const Grade01Screen({Key? key}) : super(key: key);

  @override
  State<Grade01Screen> createState() => _Grade01ScreenState();
}

class _Grade01ScreenState extends State<Grade01Screen> {
  @override
  @override
  Widget build(BuildContext context) {
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final screenSize = MediaQuery.of(context).size;
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

    return Scaffold(
      body: CustomFutureBuilder(gradeEnum: EnumVariables.grade_01), //future bu,
    );
  }
}
