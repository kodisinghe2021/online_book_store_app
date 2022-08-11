class BookModal {
  String bookid;
  String bookname;
  String bookImageUrl;
  String bookDescription;
  String price;
  String favouriteScore;
  String rank;
  String catogory;
  String publisher;
  String grade;

  BookModal({
    required this.bookid,
    required this.bookname,
    required this.price,
    required this.bookImageUrl,
    required this.bookDescription,
    required this.catogory,
    required this.favouriteScore,
    required this.grade,
    required this.publisher,
    required this.rank,
  });

//~~~~~~~~~~~~~~ get json file to an json object ~~~~~~~~~~~~~~~~~~//

  static BookModal fromJason(Map<String, dynamic> json) => BookModal(
        bookid: json['bookid'] as String,
        bookname: json['bookname'] as String,
        price: json['price'] as String,
        bookImageUrl: json['bookImageUrl'] as String,
        bookDescription: json['bookDescription'] as String,
        catogory: json['catogory'] as String,
        favouriteScore: json['favouriteScore'] as String,
        grade: json['grade'] as String,
        publisher: json['publisher'] as String,
        rank: json['rank'] as String,
      );
}
