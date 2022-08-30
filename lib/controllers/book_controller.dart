import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class BookController {


  Future<void> startSaveBookInfo(
    String bookname,
    File bookImage,
    String bookDescription,
    String price,
    String catogory,
    String publisher,
    String grade,
  ) async {
// create firebase instance for current grade
     CollectionReference bookCollectionReference =
      FirebaseFirestore.instance.collection(grade);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Upload Image to Fire Storage~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    TaskSnapshot? task =
        await uploadFile(bookImage,grade)!.whenComplete(() => Logger().i('Complete'));

//~~~~~~~~~~~~~~~~~~~ Download URL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final imageDownloadUrl = await task.ref.getDownloadURL();

//~~~~~~~~~~~~~ in here we can genarate uniqu id for single doc ~~~~~~~~~~~~~~~~~~~~//
    String docId = bookCollectionReference.doc().id;

    bookCollectionReference.doc(docId).set({
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
    }).then((value) => Logger().i('Succesfuly upload book data'));
  }

//~~~~~~~~~~~~~~~~~~~~~~ Upload Image ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  UploadTask? uploadFile(File img,String gradePath) {
    Logger().i('inside uploadFile(File img) { $img');
    try {
      final fileName = basename(img.path);
      Logger().i('file name $fileName');

      final destination = '$gradePath/$fileName';
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
