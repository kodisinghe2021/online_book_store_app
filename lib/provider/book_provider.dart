import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/models/book_modal.dart';

class BooksProvider with ChangeNotifier {
  // Book data is here. this data is only for testing purposes. this data must be fetched from the database //
  // final List<BookModal> _bookListGradeOne = [
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'wanaraja dahana',
  //       price: '230',
  //       bookImageUrl: 'https://picsum.photos/id/14/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'parisaraya',
  //       price: '450',
  //       bookImageUrl: 'https://picsum.photos/id/15/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  // ];

  // final List<BookModal> _bookListGradeTwo = [
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'wanaraja dahana',
  //       price: '230',
  //       bookImageUrl: 'https://picsum.photos/id/115/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'parisaraya',
  //       price: '450',
  //       bookImageUrl: 'https://picsum.photos/id/117/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'rachana shathakaya',
  //       price: '560',
  //       bookImageUrl: 'https://picsum.photos/id/116/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'maru sira',
  //       price: '1080',
  //       bookImageUrl: 'https://picsum.photos/id/113/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'maharaja gamunu',
  //       price: '730',
  //       bookImageUrl: 'https://picsum.photos/id/118/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'dalisa',
  //       price: '590',
  //       bookImageUrl: 'https://picsum.photos/id/119/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'aliya saha mama',
  //       price: '660',
  //       bookImageUrl: 'https://picsum.photos/id/129/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'kiyawana huruwa',
  //       price: '130',
  //       bookImageUrl: 'https://picsum.photos/id/155/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  // ];

  // final List<BookModal> _bookListGradeThree = [
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'wanaraja dahana',
  //       price: '230',
  //       bookImageUrl: 'https://picsum.photos/id/1/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'parisaraya',
  //       price: '450',
  //       bookImageUrl: 'https://picsum.photos/id/2/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'rachana shathakaya',
  //       price: '560',
  //       bookImageUrl: 'https://picsum.photos/id/3/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'maru sira',
  //       price: '1080',
  //       bookImageUrl: 'https://picsum.photos/id/4/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'maharaja gamunu',
  //       price: '730',
  //       bookImageUrl: 'https://picsum.photos/id/5/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'dalisa',
  //       price: '590',
  //       bookImageUrl: 'https://picsum.photos/id/6/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'aliya saha mama',
  //       price: '660',
  //       bookImageUrl: 'https://picsum.photos/id/7/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  //   BookModal(
  //       bookid: '1',
  //       bookname: 'kiyawana huruwa',
  //       price: '130',
  //       bookImageUrl: 'https://picsum.photos/id/8/200/280',
  //       bookDescription:
  //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
  //       catogory: 'Sinhala',
  //       favouriteScore: '23',
  //       grade: '2',
  //       publisher: 'susara',
  //       rank: '4'),
  // ];

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// here, this BookController class object will give us access to control methods in the Controller class.
  final BookController _bookController = BookController();
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// ~~~~~~~~~~~~~~~~~~~~~~  instance of the firestore ~~~~~~~~~~~~~~~~~~~~~//
  FirebaseFirestore firestore = FirebaseFirestore.instance;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// there are five grades in our book store. therefore separately we can get a specific grade book set from a list here //
  // List<BookModal> get gradeOneBooks {
  //   return [..._bookListGradeOne];
  // }

  // List<BookModal> get gradeTwoBooks {
  //   return [..._bookListGradeTwo];
  // }

  // List<BookModal> get gradeThreeBooks {
  //   return [..._bookListGradeThree];
  // }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//if some screen appears with book data from a specific grade, first we can add that list by
//calling _currentBookList then we can access that list by calling to get method.                       //                                                //

 


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//**** below code only for Administrator use. the CRUD function will adopting here. *****//

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Admin Code ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//

// 1)         pick any image from the gallery                                        //

  // this class from image pickr plugin.
  final ImagePicker _picker = ImagePicker();

  //asign empty path for file
  File _image = File("");

  File get getImage => _image;

  //        this method will select the path and file from galary and that file will be store in 'pickFile' variable
  // and the ' File(pickFile.path);' will be set _image as _image variable value.       //
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// 2) this method will save book information by calling '_bookController.startSaveBookInfo()' function in controlling
//class the controller class will upload the data to the firebase fireStore                              //
  Future<void> saveBookInformation(
    String bookname,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String grade,
  ) async {
    try {
      await _bookController.startSaveBookInfo(
          bookname, _image, bookDescription, price, catogory, publisher, grade);
    } on FirebaseException catch (e) {
      Logger().e('Error ${e.code}');
    }
    notifyListeners();
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


  void clearPath() {
    _image = File("");
  }

// Handle current book list

//  List<BookModal> _currentBookList = [

//  ];

//  Future <List<BookModal>> getCurrentBookList () async {
//     return _currentBookList;
//   }

//   void setCurrentBookList(List<BookModal> bookList) {
//     _currentBookList = bookList;
//     notifyListeners();
//   }
// fetch book details from the firebase firestore                                             //
  Future<List<BookModal>> fetchData(String refPath) async {     //List<BookModal>
//~~~~~~~~~~~~~~~~~~ Empty BookModal List ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
   List<BookModal> bookList = [];
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    try {
// this is the refference for firebase fireStore. in this lis collectionReference wiil be catch the data of'refpath'
// as a object map
      CollectionReference collectionReference =
          firestore.collection(refPath);// Eg:- 'grade-one'
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// the collectionReference.get(); method will all dos list to the snapshot variable          //
      QuerySnapshot snapshot = await collectionReference.get();
//~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// in this for loop, fetch the data one by one using 'snapshot.docs[i].data()' method. 'i' will iterate evry round.
// docs is a list, docs[i] will return the specific item in the list. when i increse one by one, then one by one all
// items in the list will save as object of BookModal, fiannly will return object list of BookModal // 
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
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      notifyListeners();
      return [];
    }
  }

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Admin Code END^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//


}
