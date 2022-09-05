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

//Task 01 #####################################################################//
  Future<List<OrderModal>> fetchOrderData() async {
    // Logger().i('Inside data fetching function');
    List<OrderModal> orders = [];
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    CollectionReference collection = _firestore.collection('order-details');
    QuerySnapshot snapshot = await collection.get();
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    for (var ordersMap in snapshot.docs) {
      //   Logger().i('DocID for book list: ${ordersMap['idOfBookList']}');
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
      await fetchOrderedBook(ordersMap['idOfBookList']);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
      Logger().w(
          'This is the last checkup for List of book data :: Length : ${_orderedBookList.length}');
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
          fullDetailsOfBookwithQnt: _orderedBookList,
        ),
      );
    }
    //  Logger().i('The list has been created :: length of list: ${orders.length}');
    return orders;
  }

//Task 02 #####################################################################//
  Future<void> fetchOrderedBook(String docID) async {
    try {
      CollectionReference collection =
          _firestore.collection('ordered-book-list');

      final booksData = await collection.doc(docID).get();
      Map<String, dynamic> bookListFrom =
          booksData.data() as Map<String, dynamic>;

      bookListFrom.forEach((key, value) async {
        Map<String, dynamic> bookMap = await getBookDataforOrder(key, value);
        //  Logger().i('Map:::${bookMap['bookname']} ');
        _orderedBookList.add(bookMap);
        Logger().i(
            'Length of fullyBookDataWithquantity ::::: ${_orderedBookList.length}');
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        // fullyBookDataWithquantity.add(await getBookDataforOrder(key, value));
        // fullyBookDataWithquantity.insert(
        //     0, await getBookDataforOrder(key, value));
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        // Logger().w('$key : $value');
      });
      Logger().i('Length of book data list ${_orderedBookList.length}');
    } on FirebaseException catch (e) {
      Logger().e('Error: : ${e.code}');
    }
  }

//Task 03 #####################################################################//
  Future<Map<String, dynamic>> getBookDataforOrder(
      String bookID, String quantity) async {
    Map<String, dynamic> bookData = {};
    try {
      CollectionReference reference = _firestore.collection('books');
      DocumentSnapshot snapshot = await reference.doc(bookID).get();
      Map<String, dynamic> bookMap = snapshot.data() as Map<String, dynamic>;
      bookData = bookMap;
      bookData.putIfAbsent('quantity', () => quantity);
      //  bookData.forEach((key, value) {
      //  Logger().i('$key : $value');
      //   });
      // Logger().i('Length of book data from Task 03 ${bookData.length}');
      return bookData;
    } on FirebaseException catch (e) {
      Logger().e('ERROR :: ${e.code}');
      return {};
    }
  }
}
