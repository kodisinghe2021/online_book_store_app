import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/screens/orders/order_confirm_screen.dart';
import 'package:online_book_store_app/widget/app_drawer.dart';
import 'package:online_book_store_app/widget/black_floating_button.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';
import 'package:online_book_store_app/screens/cart/single_cart_in_listview.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const pageKey = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//############################################################################//
  bool visible(context) {
    bool isVisibility = false;
    if (Provider.of<CartItemProvider>(context).itemCount > 0) {
      isVisibility = true;
    }
    return isVisibility;
  }

//############################################################################//
  @override
  Widget build(BuildContext context) {
    //############################################################################//
    final screenSize = MediaQuery.of(context).size;
    final cart = Provider.of<CartItemProvider>(context);
    //############################################################################//
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const BackFloatingButton(),
        appBar: const CustomAppBar(
          text: 'My Book Order',
          fontSize: 20,
        ),
        drawer: const AppDrawer(),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Visibility(
                  visible: visible(context),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
//############################################################################//
                        Card(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'මුළු මුදල රු: ${cart.calculateTotal.toString()}',
                              style: GoogleFonts.notoSerifSinhala(
                                  fontSize: 20,
                                  color: ConstantValues.primaryColor),
                            ),
                          ),
                        ),
//############################################################################//
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
                              Provider.of<CartItemProvider>(context,
                                      listen: false)
                                  .setTotal(cart.calculateTotal.toString());
                              Navigator.pushNamed(
                                  context, OrdersConfirmScreen.pageKey);
                              cart.clearMap();
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ConstantValues.secondryColor,
                              animationDuration:
                                  const Duration(milliseconds: 3000),
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Order Now',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
//############################################################################//
                      ],
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.85,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 212, 220, 217),
                  ),
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: cart.itemCount,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SingleCardInListView(index: index),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
