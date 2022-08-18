import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/cart/cart_screen.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/oreders/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            title: const Text('My Menu'),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductViewScreen.pageKey);
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.pageKey);
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('My Cart'),
            onTap: () {
              Navigator.pushReplacementNamed(context, CartScreen.pageKey);
            },
          )
        ],
      ),
    );
  }
}
