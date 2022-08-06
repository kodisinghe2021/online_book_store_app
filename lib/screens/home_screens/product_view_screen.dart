import 'package:flutter/material.dart';
import 'package:online_book_store_app/provider/user_provider.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/product-view-screen';

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [],
          ),
        ),
      ),
    );
  }
}
