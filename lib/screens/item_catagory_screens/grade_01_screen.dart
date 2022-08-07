import 'package:flutter/material.dart';
import 'package:online_book_store_app/models/book_modal.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/widget/single_book_template.dart';
import 'package:provider/provider.dart';

class Grade01Screen extends StatelessWidget {
  const Grade01Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//~~~~~~~~~ provider ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final bookData = Provider.of<BooksProvider>(context);
//~~~~~~~~~ provider ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    final screenSize = MediaQuery.of(context).size;
//~~~~~~~~~ Screen Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height * 0.85,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // color: Colors.black.withOpacity(0.5),
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3.3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: bookData.gradeOneBooks.length,
                    itemBuilder: (context, index) {
                      Provider.of<BooksProvider>(context,listen: false)
                          .setCurrentBookList(bookData.gradeOneBooks);
                      return SingleBookItemTemplate(index: index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
