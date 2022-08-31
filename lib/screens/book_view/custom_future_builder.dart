import 'package:flutter/material.dart';
import 'package:online_book_store_app/provider/book_modal.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/screens/book_view/book_item_template.dart';
import 'package:provider/provider.dart';

class CustomFutureBuilder extends StatelessWidget {
  CustomFutureBuilder({
    Key? key,
    required this.gradeEnum,
  }) : super(key: key);
  String gradeEnum;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<BooksProvider>(context, listen: false)
          .retrieveBookData(gradeEnum),
      builder: (BuildContext context, AsyncSnapshot<List<BookModal>> snapshot) {
        // Logger()
        //     .w('Snapshot data in $gradeEnum : -->${snapshot.data!.length} ');
        if (snapshot.hasData) {
          List<BookModal>? books = snapshot.data;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
            itemCount: books!.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: books[index],
              child: BookItemTemplate(),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
