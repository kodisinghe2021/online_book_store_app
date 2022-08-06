import 'package:flutter/material.dart';
import 'package:online_book_store_app/provider/user_provider.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/widget/headings.dart';
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
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () async {
                userData.logOutUser().then(
                      (value) => Navigator.popAndPushNamed(
                          context, LoginScreen.pageKey),
                    );
              },
              icon: const Icon(Icons.logout, size: 30),
            ),
          ),
          title: Heading01(text: 'Hi ${userData.userName}', fontSize: 30),
        ),
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [],
          ),
        ),
      ),
    );
  }
}
