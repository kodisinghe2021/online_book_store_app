import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/enums.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/screens/admin/admin_dashboard.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  static const pageKey = '/upload-screen';
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
//###########################################################################//
  final TextEditingController _bookname = TextEditingController();
  final TextEditingController _bookDescription = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _publisher = TextEditingController();
  final TextEditingController _writer = TextEditingController();
//###########################################################################//
  final _gradeList = [
    EnumVariables.grade_01,
    EnumVariables.grade_02,
    EnumVariables.grade_03,
    EnumVariables.grade_04,
    EnumVariables.grade_05,
  ];
//----------------------------------------------------------------------------//
  final _catogoryList = [
    EnumVariables.sinhala,
    EnumVariables.parisaraya,
    EnumVariables.ganithaya,
    EnumVariables.buddhadharmaya,
    EnumVariables.demala,
    EnumVariables.widyawa,
    EnumVariables.english,
    EnumVariables.ithihasaya,
  ];
//###########################################################################//
  String? selectedGrade;
  String? selectedCatogory;
  bool _isLoading = false;
//###########################################################################//
  DropdownMenuItem<String> buildGradeMenuItem(String itemT) =>
      DropdownMenuItem(value: itemT, child: Text(itemT));
//----------------------------------------------------------------------------//
  DropdownMenuItem<String> buildCatogoryMenuItem(String itemT) =>
      DropdownMenuItem(value: itemT, child: Text(itemT));
//###########################################################################//
//###########################################################################//
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: screenSize.width,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Consumer<BooksProvider>(builder: (context, value, child) {
                return value.getImageFile.path == ""
                    ? SizedBox(
                        height: screenSize.height * 0.1,
                        width: screenSize.width,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                value.pickImage();
                              },
                              icon: const Icon(
                                Icons.upload,
                                color: Colors.amber,
                                size: 40,
                              ),
                            ),
                            const Text("Pick Image"),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: screenSize.width * 0.7,
                        height: screenSize.width * 1,
                        child: InkWell(
                          onDoubleTap: () {
                            value.pickImage();
                          },
                          child: Image.file(
                            value.getImageFile,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
              }),

              const SizedBox(height: 20),
              //############################################################################//
              CustomTextField(
                controller: _bookname,
                lableText: 'Book Name',
                icon: const Icon(Icons.book),
              ),
              //############################################################################//
              CustomTextField(
                controller: _bookDescription,
                lableText: 'Discription',
                icon: const Icon(Icons.description),
              ),
              //############################################################################//
              CustomTextField(
                controller: _price,
                lableText: 'Price of Book',
                icon: const Icon(Icons.monetization_on_sharp),
              ),
              //############################################################################//
              CustomTextField(
                controller: _publisher,
                lableText: 'Publisher',
                icon: const Icon(Icons.local_library_rounded),
              ),
              //############################################################################//
              CustomTextField(
                controller: _writer,
                lableText: 'Writer',
                icon: const Icon(Icons.draw),
              ),
              //############################################################################//
              Container(
                width: screenSize.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Subject'),
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    isExpanded: true,
                    value: selectedCatogory,
                    items: _catogoryList.map(buildCatogoryMenuItem).toList(),
                    onChanged: (value) => setState(
                      () {
                        selectedCatogory = value;
                        Logger().w(value);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //############################################################################//
              Container(
                width: screenSize.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Grade'),
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    isExpanded: true,
                    value: selectedGrade,
                    items: _gradeList.map(buildGradeMenuItem).toList(),
                    onChanged: (value) => setState(
                      () {
                        selectedGrade = value;
                        Logger().w(value);
                      },
                    ),
                  ),
                ),
              ),
              //############################################################################//
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.6,
                height: 50,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await Provider.of<BooksProvider>(context,
                                  listen: false)
                              .uploadAndSaveBookData(
                            _bookname.text,
                            _bookDescription.text,
                            _price.text,
                            selectedCatogory.toString(),
                            _publisher.text,
                            _writer.text,
                            selectedGrade.toString(),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              title: 'Success',
                              text: 'The book data is added',
                              onConfirmBtnTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AdminDashBoard.pageKey);
                              });
                        },
                        child: const Text('Upload'),
                      ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.lableText,
    required this.icon,
    this.helperText = '',
  }) : super(key: key);

  final TextEditingController controller;
  final String lableText;
  final Icon icon;
  final String helperText;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.85,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          helperText: helperText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(169, 68, 137, 255), width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          icon: icon,
          labelText: lableText,
          labelStyle: const TextStyle(
            color: Color.fromARGB(169, 68, 137, 255),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
