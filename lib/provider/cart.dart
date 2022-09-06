import 'package:flutter/material.dart';

class CartItemModal {
  String itemId;
  String title;
  String bookID;
  String price;
  String quantity;

  CartItemModal({
    required this.itemId,
    required this.title,
    required this.bookID,
    required this.price,
    required this.quantity,
  });
}

class CartItemProvider with ChangeNotifier {
//############################################################################//
  Map<String, CartItemModal> _itemsMap = {};
//############################################################################//
  Map<String, CartItemModal> _orderedBookList = {};
//############################################################################//
//############################################################################//
  int get itemCount => _itemsMap.length;
//############################################################################//
  int get totalBooks {
    int count = 0;
    _itemsMap.forEach((key, item) {
      count += (int.parse(item.quantity));
    });

    return count;
  }

//############################################################################//
  String _totalBill = '';

  void setTotal(String total) {
    _totalBill = total;
  }

  String get getTotalBill => _totalBill;
//############################################################################//
  double get calculateTotal {
    double totalPrice = 0.0;
    _itemsMap.forEach((key, item) {
      totalPrice += (int.parse(item.price) * int.parse(item.quantity));
    });
    return totalPrice;
  }

//############################################################################//
  Map<String, CartItemModal> get cartItemMap => {..._itemsMap};
//############################################################################//
  Map<String, CartItemModal> get getOrderedBookList => {..._orderedBookList};
//############################################################################//
  void addToCart(String bookId, String title, String price, String quantity) {
    if (_itemsMap.containsKey(bookId)) {
      _itemsMap.update(
        bookId,
        (existingCartItem) => CartItemModal(
          itemId: existingCartItem.itemId,
          title: existingCartItem.title,
          bookID: existingCartItem.bookID,
          price: existingCartItem.price,
          quantity: quantity,
        ),
      );
    } else {
      _itemsMap.putIfAbsent(
        bookId,
        () => CartItemModal(
            itemId: DateTime.now().toString(),
            title: title,
            bookID: bookId,
            price: price,
            quantity: quantity),
      );
    }
    notifyListeners();
  }

//############################################################################//
  void clearMap() {
    _orderedBookList = _itemsMap;
    _itemsMap = {};
    notifyListeners();
  }
//############################################################################//
}
