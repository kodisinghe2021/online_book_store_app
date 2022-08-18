import 'package:flutter/material.dart';

class CartItemModal {
  String id;
  String title;
  String price;
  String quantity;

  CartItemModal({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartItemProvider with ChangeNotifier {
// Cart item map with unique id, this map will catch specific item in the item list      //
  Map<String, CartItemModal> _itemsMap = {};
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//getter for item count of item map                                                      //
  int get itemCount => _itemsMap.length;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//total books
  int get totalBooks {
    int count = 0;
    _itemsMap.forEach((key, item) {
      count += (int.parse(item.quantity));
    });

    return count;
  }

//Find total cost for all books in the order
  double get calculateTotal {
    double totalPrice = 0.0;
    _itemsMap.forEach((key, item) {
      totalPrice += (int.parse(item.price) * int.parse(item.quantity));
    });
    return totalPrice;
  }

// return copy of private item map                                                       //
  Map<String, CartItemModal> get cartItemMap => {..._itemsMap};
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//item adding here                                                                       //
  void addToCart(String bookId, String title, String price, String quantity) {
    if (_itemsMap.containsKey(bookId)) {
      _itemsMap.update(
        bookId,
        (existingCartItem) => CartItemModal(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: quantity,
        ),
      );
    } else {
      _itemsMap.putIfAbsent(
        bookId,
        () => CartItemModal(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: quantity),
      );
    }
    notifyListeners();
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Clear List~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  void clearMap() {
    _itemsMap = {};
    notifyListeners();
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
}
