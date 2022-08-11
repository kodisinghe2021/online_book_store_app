import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/controllers/book_controller.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/utils/util_functions.dart';
import 'package:online_book_store_app/widget/custom_buttons.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:online_book_store_app/widget/enums.dart';
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
// this field use for dropdown menu. select grade                      //
  final _gradeList = [
    EnumVariables.grade_01,
    EnumVariables.grade_02,
    EnumVariables.grade_03,
    EnumVariables.grade_04,
    EnumVariables.grade_05,
  ];

  String? selectedGrade;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//fireStore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final bool _pwVisibility = false;
  bool isLoader = false;
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
                      CustomSinhalaTextField(
                        screenSize: screenSize,
                        controller: _bookName,
                        label: 'Book Name',
                        prefixIcon: const Icon(Icons.person_add_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Book Price ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomSinhalaTextField(
                        screenSize: screenSize,
                        controller: _price,
                        label: 'Price',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Description ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomSinhalaTextField(
                        screenSize: screenSize,
                        controller: _description,
                        label: 'Discription',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Catogory ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomSinhalaTextField(
                        screenSize: screenSize,
                        controller: _catogory,
                        label: 'Catogory',
                        prefixIcon: const Icon(Icons.person_add_outlined),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Publisher ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      CustomSinhalaTextField(
                        screenSize: screenSize,
                        controller: _publisher,
                        label: 'Publisher',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Grade ~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                      Container(
                        width: screenSize.width * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ConstantValues.primaryColor, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            isExpanded: true,
                            value: selectedGrade,
                            items: _gradeList.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(
                              () {
                                this.selectedGrade = value;
                                Logger().w(value);
                              },
                            ),
                          ),
                        ),
                      ),
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
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
                          isLoading: isLoader,
                          text: 'Upload Details',
                          onTap: () async {
                            setState(() {
                              isLoader = true;
                            });
                            value
                                .saveBookInformation(
                                  _bookName.text,
                                  _description.text,
                                  _price.text,
                                  _catogory.text,
                                  _publisher.text,
                                  selectedGrade.toString(),
                                )
                                .then((value) => afterUpload());
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

  DropdownMenuItem<String> buildMenuItem(String itemT) =>
      DropdownMenuItem(value: itemT, child: Text(itemT));

  void afterUpload() {
    setState(() {
      isLoader = false;
    });
    Navigator.popAndPushNamed(context, AdminDashBoard.pageKey);
  }
}
