import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/item_catagory_screens/grade_01_screen.dart';
import 'package:online_book_store_app/screens/item_catagory_screens/grade_02_screen.dart';
import 'package:online_book_store_app/screens/item_catagory_screens/grade_03_screen.dart';
import 'package:online_book_store_app/screens/item_catagory_screens/grade_04_screen.dart';
import 'package:online_book_store_app/screens/item_catagory_screens/grade_05_screen.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/product-view-screen';

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                 Tab Controller object without initialize             //
  late TabController _controller;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                      set the TabController                         //
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                      Clear the tab controller                         //
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(text: 'Products'),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: screenSize.width * 0.98,
                height: screenSize.height * 0.05,
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: TabBar(
                    isScrollable: true,
                    physics: const ScrollPhysics(),
                    controller: _controller,
                    tabs: const [
                      Tab(text: 'Grade 01'),
                      Tab(text: 'Grade 02'),
                      Tab(text: 'Grade 03'),
                      Tab(text: 'Grade 04'),
                      Tab(text: 'Grade 05'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.99,
              height: screenSize.height * 0.85,
              child: TabBarView(
                controller: _controller,
                children: const [
                  Grade01Screen(),
                  Grade02Screen(),
                  Grade03Screen(),
                  Grade04Screen(),
                  Grade05Screen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
