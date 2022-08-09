import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/utils/util_functions.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/headings.dart';
import 'package:provider/provider.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);
  static String pageKey = '/admin-screen';
  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
// get UtilFunctions
  final UtilFunctions _utils = UtilFunctions();

//~~~~~~~~~~~~~~~~~~~  Book controller class ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  final BookController _bookController = BookController();

// loader controlling bool value
  final bool _isLoading = false;

  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _catogory = TextEditingController();
  final TextEditingController _publisher = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  String bookImageUrl = '';
  String favouriteScore = '';
  String rank = '';

  // final UtilFunctions _utils = UtilFunctions();
  // final FirebaseAuth mAuth = FirebaseAuth.instance

//fireStore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final bool _pwVisibility = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  color: const Color(0xFFFEFBF6),
                ),
                // top curved Container
                //Main heading Text
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Heading01(
                      fontSize: 40,
                      text: 'Admin DashBoard',
                    ),
                  ),
                ),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Data Input Field ~~~~~~~~~~~~~~~~~~~~~~~~~//
                SizedBox(
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Upper Gap ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      SizedBox(height: screenSize.height * 0.15),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Book Name ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _bookName,
                        label: 'Book Name',
                        prefixIcon: const Icon(Icons.person_add_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Book Price ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _price,
                        label: 'Price',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(height: screenSize.height * 0.01),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Description ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _description,
                        label: 'Discription',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Catogory ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _catogory,
                        label: 'Catogory',
                        prefixIcon: const Icon(Icons.person_add_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Publisher ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _publisher,
                        label: 'Publisher',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Grade ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      //center container
                      CustomTextField(
                        screenSize: screenSize,
                        controller: _grade,
                        label: 'Grade',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenSize.height * 0.16,
                  left: (screenSize.width - screenSize.width * 0.69) * 0.5,
                  child: SizedBox(
                    width: screenSize.width * 0.69,
                    height: screenSize.height * 0.2,
                    child: Consumer<BooksProvider>(
                      builder: (context, value, child) {
                        return value.getImage.path == ""
                            ? IconButton(
                                onPressed: () {
                                  Provider.of<BooksProvider>(context,
                                          listen: false)
                                      .selectImageFromGalary();
                                },
                                icon: const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.amber,
                                ),
                              )
                            : SizedBox(
                                width: screenSize.width * 0.97,
                                height: screenSize.height * 0.5,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Image.file(value.getImage,
                                          fit: BoxFit.fill),
                                      TextButton(
                                        onPressed: () {
                                          value.getImage.path == "";
                                          Provider.of<BooksProvider>(context,
                                                  listen: false)
                                              .selectImageFromGalary();
                                          Logger().i(
                                              '~~~~~~~~~~~~~~~~~~~~Image selected~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
                                          Logger().i(
                                              '~~~~~~~~~~~~~~~~~~~~_image : ${value.getImage}  ~~~~~~~~~~~~~~~~~~~~~~~~~');
                                        },
                                        child: const Text("Select Other Image"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                //Login button
                Positioned(
                  bottom: screenSize.height * 0.1,
                  left: (screenSize.width - screenSize.width * 0.69) * 0.5,
                  child: SizedBox(
                    width: screenSize.width * 0.69,
                    height: screenSize.height * 0.056,
                    child: Consumer<BooksProvider>(
                      builder: (context, value, child) {
                        return CustomElevatedButton(
                          text: 'Upload Details',
                          onTap: () async {
                            value
                                .saveBookInformation(
                                  _bookName.text,
                                  _description.text,
                                  _price.text,
                                  _catogory.text,
                                  _publisher.text,
                                  _grade.text,
                                )
                                .then((value) => Logger().i('Upload succes'));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
