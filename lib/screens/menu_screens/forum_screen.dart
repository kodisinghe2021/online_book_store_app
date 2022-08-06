import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);
  static const pageKey = '/forum-screen';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.blueAccent,
      ),
    );
  }
}
