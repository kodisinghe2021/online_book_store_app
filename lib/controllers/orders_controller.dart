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
  final List<Map<String, dynamic>> _orderedBookList = [];
  //############################################################################//

  Future<void> addOrderData(
    BuildContext context,
    String name,
    String nic,
    String address,
    String contact01,
    String contact02,
    String totalBill,
  ) async {
    _addBookList(context);
    _orderdetails.addAll({
      'name': name,
      'nic': nic,
      'address': address,
      'contact01': contact01,
      'contact02': contact02,
      'totalBill': totalBill,
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

//Task 01 #####################################################################//
  Future<List<OrderModal>> fetchOrderData() async {
    List<OrderModal> orders = [];
    CollectionReference collection = _firestore.collection('order-details');
    QuerySnapshot snapshot = await collection.get();
    for (var ordersMap in snapshot.docs) {
      orders.add(
        OrderModal(
          orderDetailsId: ordersMap['order-details-id'],
          address: ordersMap['address'],
          contact01: ordersMap['contact01'],
          contact02: ordersMap['contact02'],
          dateAndTime: ordersMap['date_and_time'],
          idOfBookList: ordersMap['idOfBookList'],
          name: ordersMap['name'],
          totalBill: ordersMap['totalBill'],
          nic: ordersMap['nic'],

          fullDetailsOfBookwithQnt: _orderedBookList,
        ),
      );
    }
    return orders;
  }

//Task 02 ####################################################################//

  Future<List<Map<String, dynamic>>> getOrderedBookIDs(String docID) async {
    Map<String, dynamic> mapOfbookIDsWithQuantity = {};
    try {
      CollectionReference collection =
          _firestore.collection('ordered-book-list');
      final bookdata = await collection.doc(docID).get();
      mapOfbookIDsWithQuantity = bookdata.data() as Map<String, dynamic>;
      return getBookDataforOrder(mapOfbookIDsWithQuantity);
    } on FirebaseException catch (e) {
      Logger().e('Error: : ${e.code}');
      return [];
    }
  }

//Task 03 #####################################################################//

  Future<List<Map<String, dynamic>>> getBookDataforOrder(
      Map<String, dynamic> mapOfOrderedBookdata) async {
    List<Map<String, dynamic>> orderedBookMapWithQuantity = [];
    try {
      CollectionReference collection = _firestore.collection('books');
      for (var i = 0; i < mapOfOrderedBookdata.length; i++) {
        DocumentSnapshot snapshot =
            await collection.doc(mapOfOrderedBookdata.keys.toList()[i]).get();
        Map<String, dynamic> mapFrom = snapshot.data() as Map<String, dynamic>;
        await mapFrom.putIfAbsent(
            'quantity', () => mapOfOrderedBookdata.values.toList()[i]);
        orderedBookMapWithQuantity.add(mapFrom);
      }

      return orderedBookMapWithQuantity;
    } on FirebaseException catch (e) {
      Logger().e('ERROR :: ${e.code}');
      return [];
    }
  }
}
