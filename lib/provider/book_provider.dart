import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/provider/book_modal.dart';

class BooksProvider with ChangeNotifier {
//############################################################################//
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BookController _bookController = BookController();
  late BookModal _tappedBook;
//############################################################################//
  void setBook(BookModal book) {
    _tappedBook = book;
  }

//############################################################################//
  BookModal get getTappedbook => _tappedBook;
//############################################################################//
  Future<List<BookModal>> retrieveBookData(
    String refPath,
  ) async {
    try {
      List<BookModal> bookList = [];
      CollectionReference collectionReference = _firestore.collection(refPath);
      QuerySnapshot snapshot = await collectionReference.get();

      for (var element in snapshot.docs) {
        Logger().i('bookid: ${element['bookid']}');
        Logger().i('bookname: ${element['bookname']}');
        Logger().i('price: ${element['price']}');
        Logger().i('bookImageUrl: ${element['bookImageUrl']}');
        Logger().i('bookDescription: ${element['bookDescription']}');
        Logger().i('catogory: ${element['catogory']}');
        // Logger().i('favouriteScore: ${element['favouriteScore']}');
        Logger().i('grade: ${element['grade']}');
        Logger().i('publisher: ${element['publisher']}');
        Logger().i('rank: ${element['rank']}');
        Logger().i('Grade : $refPath :: Lenth of bookList: ${bookList.length}');

        bookList.add(
          BookModal(
            bookid: element['bookid'],
            bookname: element['bookname'],
            price: element['price'],
            bookImageUrl: element['bookImageUrl'],
            bookDescription: element['bookDescription'],
            catogory: element['catogory'],
            grade: element['grade'],
            publisher: element['publisher'],
            rank: element['rank'],
          ),
        );
        Logger().i('book Modal added: :: ${bookList[0].bookid} ');
      }
      Logger().w(
          'list of return  :: length ${bookList.length}  || single item:: ${bookList[0].bookid}');
      // }
      notifyListeners();
      return bookList;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      Logger().e('Error : ${e.code}');
      notifyListeners();
      return [];
    }
  }

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//Task (0) ###################################################################//
  void clearPath() {
    _imageFile = File("");
  }

//Task 00 ####################################################################//
  final ImagePicker _picker = ImagePicker();
//............................................................................//
  File _imageFile = File('');
//............................................................................//
  File get getImageFile => _imageFile;
//............................................................................//

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
  }

//Task (1) ###################################################################//
  final BookController _bookDataHandler = BookController();
  Future<void> uploadAndSaveBookData(
    String bookname,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String writer,
    String grade,
  ) async {
    await _bookDataHandler.uploadBookData(
      bookname,
      bookDescription,
      price,
      catogory,
      publisher,
      writer,
      grade,
      _imageFile,
    );
    clearPath();
  }

//############################################################################//
  Future<void> deleteBook(
    BuildContext context,
    String docID,
  ) async {
    try {
      await _firestore.doc(docID).delete();
    } on FirebaseException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error Updating',
          text: e.code);
    }
  }

//############################################################################//
  Future<void> updateBook(BuildContext context, String docID, String priceIn,
      String discriptionIn) async {
    try {
      Logger().i("Inside update");
      await _firestore.doc(docID).update({
        'price': priceIn,
        'bookDescription': discriptionIn,
      }).then((value) => CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Success',
          text: 'Successfuly updated'));
    } on FirebaseException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error Updating',
          text: e.code);
    }
  }
//############################################################################//
}
