import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class OrderProvider with ChangeNotifier {
//############################################################################//
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//############################################################################//
  Map<String, dynamic> _bookList = {};
//############################################################################//
  Map<String, dynamic> _orderDetails = {};
//############################################################################//
  String docIdOfBookList = '';
//############################################################################//
//############################################################################//
  void setBookList(Map<String, dynamic> bookList) {
    _bookList = bookList;
    Logger().w('Book List add to OrderProvider : ${_bookList.length}');
  }
//############################################################################//
  void setOrderDetails(Map<String, dynamic> orderDetails) {
    _orderDetails = orderDetails;
    Logger().w('Order Detailst add to OrderProvider : ${_orderDetails.length}');
  }
//############################################################################//
  Future<void> _saveOrderBookListInFirebase() async {
    Logger().w(_bookList.length);
    try {
      docIdOfBookList = _firestore.collection('ordered-book-list').doc().id;
      await _firestore
          .collection('ordered-book-list')
          .doc(docIdOfBookList)
          .set(_bookList);
      Logger().w('List length : ${_bookList.length}');
      Logger().w('List saved');
    } on FirebaseException catch (e) {
      Logger().e(e.code);
    }
    notifyListeners();
  }

//############################################################################//
  Future<void> saveOrderDetailsInFirebase() async {
    Logger().w(_orderDetails.length);
    try {
      await _saveOrderBookListInFirebase();
      _orderDetails.putIfAbsent('idOfBookList', () => docIdOfBookList);
    String docIdOfBookDetails = _firestore.collection('order-details').doc().id;
      await _firestore
          .collection('order-details')
          .doc(docIdOfBookDetails)
          .set(_orderDetails);
      Logger().w('List length : ${_bookList.length}');
      Logger().w('List saved');
    } on FirebaseException catch (e) {
      Logger().e(e.code);
    }
    notifyListeners();
  }
//############################################################################//
}
