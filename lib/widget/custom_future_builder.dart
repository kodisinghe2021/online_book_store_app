import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/models/book_modal.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/screens/single_book_full_view/single_book_full_view.dart';
import 'package:online_book_store_app/widget/enums.dart';
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
          .fetchData(gradeEnum),
      builder: (BuildContext context, AsyncSnapshot<List<BookModal>> snapshot) {
        if (snapshot.hasData) {
          List<BookModal>? books = snapshot.data;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3.3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
            itemCount: books!.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SingleBookFullViewScreen.pageKey);
                        },
                        child: Image.network(
                          books[index].bookImageUrl,
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
                        'Price: ${books[index].price}',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
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
                      books[index].bookname,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
