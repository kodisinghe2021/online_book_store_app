import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderController {
//############################################################################//
  final Map<String, dynamic> _bookList = {};
//############################################################################//
  final Map<String, dynamic> _orderdetails = {};
//############################################################################//
//############################################################################//
  Future<void> addOrderData(
    BuildContext context,
    String name,
    String nic,
    String address,
    String contact01,
    String contact02,
  ) async {
    _addBookList(context);
    _orderdetails.addAll({
      'name': name,
      'nic': nic,
      'address': address,
      'contact01': contact01,
      'contact02': contact02,
      'date_and_time': DateTime.now().toString()
    });
    Logger().i('_orderdetails is added: ${_orderdetails.length}');
    Provider.of<OrderProvider>(context, listen: false)
        .setOrderDetails(_orderdetails);
  }

//############################################################################//
  void _addBookList(BuildContext context) {
    Map<String, CartItemModal> itemList =
        Provider.of<CartItemProvider>(context, listen: false)
            .getOrderedBookList;
    Logger().i('Item list length: ${itemList.length}');
    itemList.forEach((key, value) {
      _bookList.putIfAbsent(key, () => value.quantity);
    });
    Logger().i('book list length: ${_bookList.length}');
    Provider.of<OrderProvider>(context, listen: false).setBookList(_bookList);
  }
//############################################################################//

}
