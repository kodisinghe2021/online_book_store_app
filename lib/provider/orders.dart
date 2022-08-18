import 'package:flutter/foundation.dart';
import 'package:online_book_store_app/provider/cart.dart';

class OrderItemModal {
  final String id;
  final String totalAmount;
  final List<CartItemModal> bookItems;
  final DateTime dateTime;

  OrderItemModal({
    required this.id,
    required this.totalAmount,
    required this.bookItems,
    required this.dateTime,
  });
}

class OrderItemProvider with ChangeNotifier {
  final List<OrderItemModal> _orderItemList = [];

  List<OrderItemModal> get getOrderItem {
    return [..._orderItemList];
  }

  void addOrder(List<CartItemModal> cartItemList, double totalAmount) {
    _orderItemList.insert(
      0,
      OrderItemModal(
        id: DateTime.now().toString(),
        totalAmount: totalAmount.toString(),
        bookItems: cartItemList,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  int get itemCount => _orderItemList.length;
}
