import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/orders/order_screen.dart';

class OnlinePayment extends StatelessWidget {
  const OnlinePayment({Key? key}) : super(key: key);
  static const pageKey = '/online-payment-screen';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Order'),
      ),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
             // Navigator.pushNamed(context, OrderScreen.pageKey);
            },
            child: const Text('Pay'),
          ),
        ),
      ),
    );
  }
}
