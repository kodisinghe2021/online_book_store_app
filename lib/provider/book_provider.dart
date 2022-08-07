import 'package:flutter/widgets.dart';
import 'package:online_book_store_app/models/book_modal.dart';

class BooksProvider with ChangeNotifier {
  final List<BookModal> _bookListGradeOne = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/14/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/15/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/16/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/17/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/18/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/19/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/123/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/145/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];

  final List<BookModal> _bookListGradeTwo = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/115/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/117/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/116/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/113/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/118/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/119/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/129/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/155/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];


  final List<BookModal> _bookListGradeThree = [
    BookModal(
        bookid: '1',
        bookname: 'wanaraja dahana',
        price: '230',
        bookImageUrl: 'https://picsum.photos/id/1/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'parisaraya',
        price: '450',
        bookImageUrl: 'https://picsum.photos/id/2/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'rachana shathakaya',
        price: '560',
        bookImageUrl: 'https://picsum.photos/id/3/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maru sira',
        price: '1080',
        bookImageUrl: 'https://picsum.photos/id/4/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'maharaja gamunu',
        price: '730',
        bookImageUrl: 'https://picsum.photos/id/5/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'dalisa',
        price: '590',
        bookImageUrl: 'https://picsum.photos/id/6/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'aliya saha mama',
        price: '660',
        bookImageUrl: 'https://picsum.photos/id/7/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
    BookModal(
        bookid: '1',
        bookname: 'kiyawana huruwa',
        price: '130',
        bookImageUrl: 'https://picsum.photos/id/8/200/280',
        bookDescription:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        catogory: 'Sinhala',
        favouriteScore: '23',
        grade: '2',
        publisher: 'susara',
        rank: '4'),
  ];








  List<BookModal> get gradeOneBooks {
    return [..._bookListGradeOne];
  }

  List<BookModal> get gradeTwoBooks {
    return [..._bookListGradeTwo];
  }

 List<BookModal> get gradeThreeBooks {
    return [..._bookListGradeThree];
  }

//~~~~~~~~~~~~~~~~~~~~~~Set Currently active book list~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  List<BookModal> _currentBookList = [];

  List<BookModal> get getCurrentBookList {
    return _currentBookList;
  }

  void setCurrentBookList(List<BookModal> bookList) {
    _currentBookList = bookList;
    notifyListeners();
  }
//~~~~~~~~~~~~~~~~~~~~~~Set Currently active book list~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

}
