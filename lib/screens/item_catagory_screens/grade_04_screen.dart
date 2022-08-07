import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/headings.dart';

class Grade04Screen extends StatelessWidget {
  const Grade04Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Heading01(text: 'Grade 04'),
          ),
        ),
      ),
    );
  }
}
