// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// class UpadateScreen extends StatelessWidget {
//   const UpadateScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //final book = Provider.of<BooksProvider>(context).getTappedbook;
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SizedBox(
//         width: screenSize.width,
//         height: screenSize.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 40,
//               width: screenSize.width * 0.6,
//               child: ElevatedButton(
//                   onPressed: () {
//                     // Provider.of<BooksProvider>(context, listen: false)
//                     //     .updateBook(context, book.bookid, 'updated', 'updated');
//                     Logger().i('Clicked');
//                     print('object');
//                   },
//                   child: const Text('OK')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
