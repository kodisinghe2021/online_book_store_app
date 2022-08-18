import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/screens/cart/cart_screen.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
    required this.value,
  }) : super(key: key);
  final String value;
//set visible
  bool isvisible(BuildContext context) {
    bool visibility = false;
    if (Provider.of<CartItemProvider>(context, listen: false).itemCount > 0) {
      visibility = true;
    }
    return visibility;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.pageKey);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
            ),
            Visibility(
              visible: isvisible(context),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    value,
                    style: const TextStyle(color: ConstantValues.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
