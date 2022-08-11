import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_future_builder.dart';
import 'package:online_book_store_app/widget/enums.dart';

class Grade03Screen extends StatelessWidget {
  const Grade03Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final screenSize = MediaQuery.of(context).size;
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

    return Scaffold(
      body: CustomFutureBuilder(gradeEnum: EnumVariables.grade_03), //future bu,
    );
  }
}
