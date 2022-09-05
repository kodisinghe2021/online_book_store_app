import 'package:online_book_store_app/provider/book_modal.dart';

class OrderModal {
  String orderDetailsId; //order-details-id

  String address;

  String contact01;

  String contact02;

  String dateAndTime;

  String idOfBookList;

  String name;

  String nic;

  List<Map<String, dynamic>> fullDetailsOfBookwithQnt;

  OrderModal({
    required this.orderDetailsId,
    required this.address,
    required this.contact01,
    required this.contact02,
    required this.dateAndTime,
    required this.idOfBookList,
    required this.name,
    required this.nic,
    required this.fullDetailsOfBookwithQnt,
    // required this.bookListMap,
  });
}
