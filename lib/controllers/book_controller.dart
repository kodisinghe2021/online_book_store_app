import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class BookController {
  //############################################################################//
  final FirebaseFirestore _bookRef = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//############################################################################//
//Task (3) ###################################################################//
  Future<String> _uploadImageFile(String grade, File file) async {
    Logger().i('In image uploading screen $grade --> ${file.path.toString()}');

    String downloadUrl = '';
    try {
      if (file.path.isNotEmpty) {
        final fileName = basename(file.path);
        final destination = '$grade/$fileName';
        final firebaseReference = _firebaseStorage.ref(destination);
//----------------------------------------------------------------------------//
        TaskSnapshot task = await firebaseReference.putFile(file);
//----------------------------------------------------------------------------//
        downloadUrl = await getDownloadUrl(task);
      }
      Logger().i('Successfully uploaded. :: download url :  $downloadUrl');
    } catch (e) {
      Logger().e(e);
      return '';
    }
    return downloadUrl;
  }

//Task (4) ###################################################################//
  Future<String> getDownloadUrl(TaskSnapshot task) async =>
      await task.ref.getDownloadURL();
//Task (2) ###################################################################//
  Future<void> uploadBookData(
    String bookname,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String writer,
    String grade,
    File image,
  ) async {
    String imageUrl = await _uploadImageFile(grade, image);
    Logger().i('inside upload book data:: Download url : $imageUrl');
    String docID = _bookRef.collection(grade).doc().id;

    await _bookRef.collection('books').doc(docID).set({
      'bookid': docID,
      'bookname': bookname,
      'bookImageUrl': imageUrl,
      'bookDescription': bookDescription,
      'price': price,
      'rank': '0',
      'catogory': catogory,
      'publisher': publisher,
      'writer': writer,
      'grade': grade,
    }).then((value) {});
  }
//#######################################################################//
}
