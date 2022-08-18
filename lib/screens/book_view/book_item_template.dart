import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_modal.dart';
import 'package:online_book_store_app/provider/book.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/screens/book_view/single_book_full_view.dart';
import 'package:online_book_store_app/widget/favorite_toggle_icon.dart';
import 'package:provider/provider.dart';

class BookItemTemplate extends StatelessWidget {
  BookItemTemplate({
    Key? key,
  }) : super(key: key);
  final TextEditingController _inputController = TextEditingController();
  // int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BookModal>(context);
    final cart = Provider.of<CartItemProvider>(context);
    //  bool isInvalidItemCount = false;
    return Stack(
      children: [
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Book Image ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () {
                Provider.of<BooksProvider>(context, listen: false)
                    .setBook(book);
                Navigator.pushNamed(context, SingleBookFullViewScreen.pageKey);
              },
              child: Image.network(
                book.bookImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Book Name~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        Container(
          decoration: BoxDecoration(
            color: ConstantValues.primaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            book.bookname,
            style: const TextStyle(color: Colors.white),
          ),
        ),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Favorite Toggle Button~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: ConstantValues.primaryColor.withOpacity(0.9),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'මිල: ${book.price}',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const FavoriteToggleIcon(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext cotext) => AlertDialog(
                        title: const Text('අවශ්‍ය පොත් ප්‍රමාණය ඇතුල් කරන්න'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _inputController,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              cart.addToCart(
                                book.bookid,
                                book.bookname,
                                book.price,
                                _inputController.text,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded),
                  iconSize: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
      ],
    );
  }

  // Future<bool?> toast() async {
  //   return Fluttertoast.showToast(
  //       msg: "This is Center Short Toast",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
  // void showInputBox() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('අවශ්‍ය පොත් ප්‍රමාණය ඇතුල් කරන්න'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const SizedBox(height: 20),
  //             TextField(
  //               keyboardType: TextInputType.number,
  //               controller: _inputController,
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               _itemCount = int.parse(_inputController.text);
  //               Logger().w('Added Quantity in alert box:  $_itemCount');
  //               Navigator.pop(context);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
}
