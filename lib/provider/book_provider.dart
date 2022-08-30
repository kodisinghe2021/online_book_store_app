import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/provider/book_modal.dart';

class BooksProvider with ChangeNotifier {
//############################################################################//
  final BookController _bookController = BookController();
//############################################################################//
  FirebaseFirestore firestore = FirebaseFirestore.instance;
//############################################################################//
  late BookModal _tappedBook;
//############################################################################//
  void setBook(BookModal book) {
    _tappedBook = book;
  }

//############################################################################//
  BookModal get getTappedbook => _tappedBook;
//############################################################################//
  Future<List<BookModal>> retrieveBookData(String refPath) async {
    List<BookModal> bookList = [];
    try {
      CollectionReference collectionReference = firestore.collection(refPath);
      QuerySnapshot snapshot = await collectionReference.get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        Map<String, dynamic> bookMap =
            snapshot.docs[i].data() as Map<String, dynamic>;
        bookList.add(BookModal(
          bookid: bookMap['bookid'],
          bookname: bookMap['bookname'],
          price: bookMap['price'],
          bookImageUrl: bookMap['bookImageUrl'],
          bookDescription: bookMap['bookDescription'],
          catogory: bookMap['catogory'],
          favouriteScore: bookMap['favouriteScore'],
          grade: bookMap['grade'],
          publisher: bookMap['publisher'],
          rank: bookMap['rank'],
        ));
      }
      notifyListeners();
      return bookList;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      notifyListeners();
      return [];
    }
  }
//############################################################################//
}
