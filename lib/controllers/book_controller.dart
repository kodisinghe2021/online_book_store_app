import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class BookController {
  final CollectionReference _g01_bookCollectionReference =
      FirebaseFirestore.instance.collection('grade-one');


  Future<void> startSaveBookInfo(
    String bookname,
    File bookImage,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String grade,
  ) async {
    Logger().i(
        '`````````````` inside provider saveBookInfo( method~~~~~~~~~~~~~~~~~~~~~~');
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Upload Image to Fire Storage~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    TaskSnapshot? task = await uploadFile(bookImage);
    Logger().i(' ~~~~~~~~~~~~~~~~~~~~~~');
//~~~~~~~~~~~~~~~~~~~~~~~~~ file is uploading......................................//

//~~~~~~~~~~~~~~~~~~~ Download URL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final imageDownloadUrl = await task!.ref.getDownloadURL();
    Logger().w(' ~~~~~~~~~~~ Download url: $imageDownloadUrl ~~~~~~~~~~~');
//~~~~~~~~~~~~~ in here we can genarate uniqu id for single doc ~~~~~~~~~~~~~~~~~~~~//

    String docId = _g01_bookCollectionReference.doc().id;

    _g01_bookCollectionReference.doc(docId).set ({
      'bookid': docId,
      'bookname': bookname,
      'bookImageUrl': imageDownloadUrl,
      'bookDescription': bookDescription,
      'price': price,
      'favouriteScore': '0',
      'rank': '0',
      'catogory': catogory,
      'publisher': publisher,
      'grade': grade,
    }).then((value) => Logger().i('Succesfuly upload nook data'));
  }

//~~~~~~~~~~~~~~~~~~~~~~ Upload Image ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  UploadTask? uploadFile(File img) {
    Logger().i('inside uploadFile(File img) { $img');
    try {
      final fileName = basename(img.path);
      Logger().i('file name $fileName');

      final destination = 'grade-01/$fileName';
      Logger().i('destination $destination');

      final ref = FirebaseStorage.instance.ref(destination);
      Logger().i('ref $ref');

      Logger().i('ref.putFile(img); executed with $img');
      return ref.putFile(img);
    } catch (e) {
      Logger().e('Error: $e');
      return null;
    }
  }
}
