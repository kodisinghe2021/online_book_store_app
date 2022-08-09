import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/models/book_modal.dart';

class BooksProvider with ChangeNotifier {
  final List<BookModal> _bookListGradeOne = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/14/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/15/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/16/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/17/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/18/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/19/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/123/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/145/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];

  final List<BookModal> _bookListGradeTwo = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/115/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/117/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/116/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/113/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/118/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/119/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/129/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/155/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];

  final List<BookModal> _bookListGradeThree = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/1/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/2/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/3/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/4/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/5/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/6/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/7/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/8/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];

  final BookController _bookController = BookController();

  List<BookModal> get gradeOneBooks {
    return [..._bookListGradeOne];
  }

  List<BookModal> get gradeTwoBooks {
    return [..._bookListGradeTwo];
  }

  List<BookModal> get gradeThreeBooks {
    return [..._bookListGradeThree];
  }

//~~~~~~~~~~~~~~~~~~~~~~Set Currently active book list~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  List<BookModal> _currentBookList = [];

  List<BookModal> get getCurrentBookList {
    return _currentBookList;
  }

  void setCurrentBookList(List<BookModal> bookList) {
    _currentBookList = bookList;
    notifyListeners();
  }
//~~~~~~~~~~~~~~~~~~~~~~Set Currently active book list~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~Pick image ***** Admin Use Only ******~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  final ImagePicker _picker = ImagePicker();

  //asign empty path for file
  File _image = File("");

  File get getImage => _image;

  //---------------------uploading function
  Future<void> selectImageFromGalary() async {
    try {
      // Pick an image
      final XFile? pickFile = await _picker.pickImage(
          source: ImageSource.gallery); // check pickFile is empty or not
      if (pickFile != null) {
        //assign path for file
        _image = File(pickFile.path);
        Logger().i(
            '~~~~~`Image Picked and save path in _image ~~~~~ Paht is: $_image');
      } else {
        Logger().w("File Not Selected");
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
  }

  void clearPath() {
    _image = File("");
    Logger().i('~~~~~~~~~~~~~~~~~~~~~ path clear now path:  $_image');
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Start save book information ~~~~~~~~~~~~~~~~~~~~~~~//

  Future<void> saveBookInformation(
    String bookname,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String grade,
  ) async {
    Logger().i(
        '`````````````` inside provider startSaveBookInformation( method~~~~~~~~~~~~~~~~~~~~~~');
    try {
      await _bookController.startSaveBookInfo(
          bookname, _image, bookDescription, price, catogory, publisher, grade);
      Logger().i('Successfully saved~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    } on FirebaseException catch (e) {
      Logger().e('Error ${e.code}');
    }
    notifyListeners();
  }
}
