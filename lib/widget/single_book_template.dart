import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/screens/single_book_full_view/single_book_full_view.dart';
import 'package:provider/provider.dart';

class SingleBookItemTemplate extends StatelessWidget {
  const SingleBookItemTemplate({
    Key? key,
    required this.index,
  }) : super(key: key);
  final index;
  @override
  Widget build(BuildContext context) {
    //~~~~~~~~~ provider ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final bookData = Provider.of<BooksProvider>(context);
//~~~~~~~~~ provider ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SingleBookFullViewScreen.pageKey);
              },
              child: Image.network(
                bookData.getCurrentBookList[index].bookImageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: ConstantValues.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'Price: ${bookData.getCurrentBookList[index].price}',
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ConstantValues.primaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            bookData.getCurrentBookList[index].bookname,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
