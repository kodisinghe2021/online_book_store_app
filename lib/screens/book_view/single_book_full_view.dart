import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/screens/admin/admin_screen_tab_pages/upload_screen.dart';
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
  String initPrice = '';
  String initDescription = '';
  bool _isExpand = false;
//############################################################################//
  final TextEditingController _inputController = TextEditingController();
  late TextEditingController _updatePrice; // = TextEditingController();
  late TextEditingController _updateDiscription; // = TextEditingController();

//############################################################################//
  @override
  Widget build(BuildContext context) {
//############################################################################//
    final book = Provider.of<BooksProvider>(context).getTappedbook;
    final cart = Provider.of<CartItemProvider>(context);
    final isAdmin = Provider.of<UserAuthController>(context).checkAdministrator;
    final screenSize = MediaQuery.of(context).size;
    _updateDiscription = TextEditingController(text: book.bookDescription);
    _updatePrice = TextEditingController(text: book.price);
//############################################################################//
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        floatingActionButton: const BackFloatingButton(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: screenSize.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
//############################################################################//
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.55,
                    child: Image.network(book.bookImageUrl, fit: BoxFit.fill),
                  ),
                ),
//############################################################################//
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildRating(),
                      if (isAdmin)
                        IconButton(
                          onPressed: () {
                            print('Clicked');
                            setState(() {
                              _isExpand = !_isExpand;
                            });
                          },
                          icon: const Icon(
                            Icons.change_circle_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      if (isAdmin)
                        IconButton(
                          onPressed: () {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.confirm,
                                onConfirmBtnTap: () {
                                  Logger().i('Clicked');
                                });

                            // Provider.of<BooksProvider>(context, listen: false)
                            //     .deleteBook(context, book.bookid);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext cotext) => AlertDialog(
                              title: const Text(
                                  'අවශ්‍ය පොත් ප්‍රමාණය ඇතුල් කරන්න'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _inputController,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cart.addToCart(
                                      book.bookid,
                                      book.bookname,
                                      book.price,
                                      _inputController.text,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                        color: ConstantValues.primaryColor,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
//############################################################################//
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
                        style:
                            TextStyle(fontSize: 15, color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                // const SizedBox(height: 15),
                //############################################################################//
                if (_isExpand)
                  SizedBox(
                    height: 250,
                    width: screenSize.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _updatePrice,
                          lableText: 'Price',
                          icon: const Icon(Icons.price_change),
                        ),
                        CustomTextField(
                          controller: _updateDiscription,
                          lableText: 'Discription',
                          icon: const Icon(Icons.description_outlined),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: screenSize.width * 0.6,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              Logger().i('clicked');
                              // CoolAlert.show(
                              //     context: context,
                              //     type: CoolAlertType.confirm,
                              //     onConfirmBtnTap: () {
                              //       Logger().i('Clicked');
                              //     });
                              Provider.of<BooksProvider>(context, listen: false)
                                  .updateBook(
                                context,
                                book.bookid,
                                _updatePrice.text,
                                _updateDiscription.text,
                              );
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                //############################################################################//
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
              ],
            ),
          ),
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
