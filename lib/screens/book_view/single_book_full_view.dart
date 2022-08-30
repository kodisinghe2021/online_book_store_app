import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/widget/black_floating_button.dart';
import 'package:online_book_store_app/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class SingleBookFullViewScreen extends StatefulWidget {
  const SingleBookFullViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/single-book-item-view-screen';

  @override
  State<SingleBookFullViewScreen> createState() =>
      _SingleBookFullViewScreenState();
}

class _SingleBookFullViewScreenState extends State<SingleBookFullViewScreen> {
  double ratingScore = 1.0;

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BooksProvider>(context).getTappedbook;

    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        floatingActionButton: BackFloatingButton(),
        body: Container(
          width: screenSize.width,
          height: screenSize.height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Stack(children: [
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Image~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.55,
                child: Image.network(book.bookImageUrl, fit: BoxFit.fill),
              ),
            ),
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Details column~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.3,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildRating(),
                              IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.shopping_cart),
                                color: ConstantValues.primaryColor,
                                iconSize: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => showRatingBox(),
                          child: const Material(
                            type: MaterialType.card,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            elevation: 5,
                            child: Text(
                              '  Rate this book  ',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      // const SizedBox(height: 15),
                      //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Name~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          book.bookname,
                          style: GoogleFonts.notoSerifSinhala(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'මිල: ${book.price}.00',
                          style: GoogleFonts.notoSerifSinhala(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'විස්තරය: ${book.bookDescription}.',
                          style: GoogleFonts.notoSerifSinhala(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'විෂය: ${book.catogory}',
                              style: GoogleFonts.notoSerifSinhala(
                                fontSize: 15,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Text(
                              'ශ්‍රේණිය: ${book.grade}',
                              style: GoogleFonts.notoSerifSinhala(
                                fontSize: 15,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                    ],
                  ),
                ),
              ),
            ),
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
          ]),
        ),
      ),
    );
  }

  Widget buildRating() => RatingBar.builder(
        itemSize: 30,
        initialRating: ratingScore,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, rate) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            ratingScore = rating;
          });
        },
      );

  void showRatingBox() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Rate This Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rate This Book'),
              const SizedBox(height: 20),
              buildRating(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

