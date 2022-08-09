import 'package:flutter/material.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';

class SingleBookFullViewScreen extends StatefulWidget {
  const SingleBookFullViewScreen({Key? key}) : super(key: key);
static const pageKey = '/single-book-item-view-screen';
  @override
  State<SingleBookFullViewScreen> createState() =>
      _SingleBookFullViewScreenState();
}

class _SingleBookFullViewScreenState extends State<SingleBookFullViewScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.9,
          child: Card(
            child: Stack(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
