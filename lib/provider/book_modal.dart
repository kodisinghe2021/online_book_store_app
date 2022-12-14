import 'package:flutter/material.dart';

class BookModal with ChangeNotifier {
  String bookid;
  String bookname;
  String bookImageUrl;
  String bookDescription;
  String price;
  String rank;
  String catogory;
  String publisher;
  String grade;
  bool isFavorite;
  BookModal({
    required this.bookid,
    required this.bookname,
    required this.price,
    required this.bookImageUrl,
    required this.bookDescription,
    required this.catogory,
    required this.grade,
    required this.publisher,
    required this.rank,
    this.isFavorite = false,
  });
//###############################################//
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
