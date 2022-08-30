import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/enums.dart';
import 'package:online_book_store_app/screens/book_view/custom_future_builder.dart';
import 'package:online_book_store_app/widget/app_drawer.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/product-view-screen';

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
//############################################################################//
  late TabController _controller;
//############################################################################//
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }
//############################################################################//
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//############################################################################//
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(text: 'Products'),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: screenSize.width * 0.98,
                  height: screenSize.height * 0.05,
                  child: Center(
                    child: TabBar(
                      labelColor: ConstantValues.primaryColor,
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
              const SizedBox(height: 7),
              SizedBox(
                width: screenSize.width * 0.95,
                height: screenSize.height * 0.85,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    CustomFutureBuilder(gradeEnum: EnumVariables.grade_01),
                    CustomFutureBuilder(gradeEnum: EnumVariables.grade_02),
                    CustomFutureBuilder(gradeEnum: EnumVariables.grade_03),
                    CustomFutureBuilder(gradeEnum: EnumVariables.grade_04),
                    CustomFutureBuilder(gradeEnum: EnumVariables.grade_05),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
