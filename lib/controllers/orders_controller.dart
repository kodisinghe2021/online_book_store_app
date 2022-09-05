import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/models/order_modal.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderController {
//############################################################################//
  final Map<String, dynamic> _bookList = {};
//############################################################################//
  final Map<String, dynamic> _orderdetails = {};
//############################################################################//
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<List<OrderModal>> fetchOrderData() async {
    Logger().i('Inside data fetching function');
    List<OrderModal> orders = [];
    CollectionReference collection = _firestore.collection('order-details');
    QuerySnapshot snapshot = await collection.get();
    for (var ordersMap in snapshot.docs) {
      Logger().i('DocID for book list: ${ordersMap['idOfBookList']}');
      final Map<String, dynamic> bookMap =
          await _fetchOrderedBook(ordersMap['idOfBookList']);
      orders.add(
        OrderModal(
          orderDetailsId: ordersMap['order-details-id'],
          address: ordersMap['address'],
          contact01: ordersMap['contact01'],
          contact02: ordersMap['contact02'],
          dateAndTime: ordersMap['date_and_time'],
          idOfBookList: ordersMap['idOfBookList'],
          name: ordersMap['name'],
          nic: ordersMap['nic'],
          bookListMap: bookMap,
        ),
      );
    }
    Logger().i('The list has been created :: length of list: ${orders.length}');
    return orders;
  }

  Future<Map<String, dynamic>> _fetchOrderedBook(String docID) async {
    Logger().i('Inside data fetching _fetchOrderedBook(String docID) $docID');
    try {
//this book data map have { bookID : quantity }
      Map<String, dynamic> bookMap = {};
      CollectionReference collection =
          _firestore.collection('ordered-book-list');
      Logger().i('Collection created');
      final booksData = await collection.doc(docID).get();
      Map<String, dynamic> bookListFrom =
          booksData.data() as Map<String, dynamic>;

      Logger().i('Ordered book list length :${bookListFrom.length}');
      if (bookListFrom.isNotEmpty) {
        bookMap = bookListFrom;
      } else {
        return bookMap = {};
      }

      Logger().i(
          'The list has been created :: length of list: ${bookListFrom.length}');
      return bookMap;
    } on FirebaseException catch (e) {
      Logger().e('Error: : ${e.code}');
      return {};
    }
  }
}
