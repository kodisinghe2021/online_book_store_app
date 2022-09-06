import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/controllers/orders_controller.dart';
import 'package:online_book_store_app/models/order_modal.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({Key? key}) : super(key: key);

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: OrderController().fetchOrderData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<OrderModal>> snapshot) {
            if (snapshot.hasData) {
              List<OrderModal>? order = snapshot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: order!.length,
                itemBuilder: (context, index) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: screenSize.width,
                    // height: screenSize.height * 0.4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Card(
                      color: const Color.fromARGB(255, 242, 245, 229),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Align(
                                alignment: Alignment.topLeft,
                                child: TextMokup(
                                  text: 'Rs: ${order[index].totalBill}0',
                                  size: 25,
                                  color: Colors.redAccent,
                                )),
                            TextMokup(
                              text: order[index].name,
                              color: const Color.fromARGB(255, 7, 155, 108),
                              size: 30,
                            ),
                            const Divider(),
                            TextMokup(text: order[index].address),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextMokup(
                                  text: order[index].contact01,
                                  color: Colors.blueAccent,
                                ),
                                TextMokup(
                                  text: order[index].contact02,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                TextMokup(
                                  text: order[index].nic,
                                  color:
                                      const Color.fromARGB(255, 70, 120, 146),
                                ),
                                const SizedBox(width: 20),
                                TextMokup(
                                  text:
                                      order[index].dateAndTime.substring(0, 10),
                                ),
                                const SizedBox(width: 10),
                                TextMokup(
                                  text: order[index]
                                      .dateAndTime
                                      .substring(11, 16),
                                  size: 18,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isExpand = !_isExpand;
                                });
                              },
                              child: Container(
                                width: screenSize.width,
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color.fromARGB(255, 222, 226, 202),
                                ),
                                child: _isExpand
                                    ? const Icon(
                                        Icons.expand_less,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.expand_more,
                                        color: Colors.black,
                                      ),
                              ),
                            ),
                            if (_isExpand)
                              Container(
                                width: screenSize.width * 0.9,
                                height: screenSize.height * 0.5,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: FutureBuilder(
                                    future: OrderController().getOrderedBookIDs(
                                        order[index].idOfBookList),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                List<Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        List<Map<String, dynamic>>?
                                            dataListOfMaps = snapshot.data;

                                        return ListView.builder(
                                          itemCount: dataListOfMaps!.length,
                                          itemBuilder: (context, indexI) =>
                                              SizedBox(
                                            width: screenSize.width * 0.9,
                                            child: Column(
                                              children: [
                                                const Divider(),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: screenSize.width *
                                                          0.6,
                                                      width: screenSize.width *
                                                          0.4,
                                                      child: Card(
                                                          child: Image.network(
                                                              dataListOfMaps[
                                                                      index][
                                                                  'bookImageUrl'])),
                                                    ),
                                                    SizedBox(
                                                      height: screenSize.width *
                                                          0.6,
                                                      width: screenSize.width *
                                                          0.4,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                TextMokup(
                                                                  text: dataListOfMaps[
                                                                          indexI]
                                                                      [
                                                                      'bookname'],
                                                                ),
                                                                TextMokup(
                                                                  size: 15,
                                                                  text:
                                                                      'Rs: ${dataListOfMaps[indexI]['price']}.00',
                                                                ),
                                                                TextMokup(
                                                                  text:
                                                                      'Quantity : ${dataListOfMaps[indexI]['quantity']}',
                                                                ),
                                                                TextMokup(
                                                                    size: 14,
                                                                    text:
                                                                        'total from this book:\n Rs: ${totalPrize(dataListOfMaps[indexI]['price'], dataListOfMaps[indexI]['quantity'])}.00'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('No data'),
              );
            } else {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }

  String totalBillCalculate(String orderLength, String price, String quantity) {
    String totalCount;
    double total = 0.0;
    for (var i = 0; i < int.parse(orderLength); i++) {
      total += (double.parse(price) * double.parse(quantity));
    }
    return total.toString();
  }

  String totalPrize(String price, String quantity) =>
      (int.parse(price) * int.parse(quantity)).toString();
}

class TextMokup extends StatelessWidget {
  const TextMokup({
    Key? key,
    required this.text,
    this.size = 20,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.acme(
        fontSize: size,
        color: color,
      ),
    );
  }
}
