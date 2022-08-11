import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_future_builder.dart';
import 'package:online_book_store_app/widget/enums.dart';

class Grade05Screen extends StatelessWidget {
  const Grade05Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFutureBuilder(gradeEnum: EnumVariables.grade_05), //future bu,
    );
  }
}
