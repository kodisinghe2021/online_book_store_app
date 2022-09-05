import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/controllers/orders_controller.dart';
import 'package:online_book_store_app/models/order_modal.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        OrderController().fetchOrderData();
      }),
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
                            //  const SizedBox(height: 20),
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
                                      const Color.fromARGB(255, 237, 144, 144),
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
                            Text(
                                'Length of book List ${order[index].fullDetailsOfBookwithQnt.length}'),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     width: screenSize.width,
                            //     height: 30,
                            //     decoration: const BoxDecoration(
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(10),
                            //       ),
                            //       color: Color.fromARGB(255, 222, 226, 202),
                            //     ),
                            //     child: const Icon(
                            //       Icons.expand_more,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),
                            // ListTile(
                            //   title: order[0].fullDetailsOfBookwithQnt[0]
                            //       ['bookname'],
                            // ),
                            // ListView.builder(
                            //   itemCount:
                            //       order[index].fullDetailsOfBookwithQnt.length,
                            //   itemBuilder: (context, indexL) => SizedBox(
                            //     //  height: 300,
                            //     //  width: screenSize.width,
                            //     child: Column(
                            //       children: [
                            //         const Text('RRRRRRRRRRRR'),
                            //         Text(order[index]
                            //                 .fullDetailsOfBookwithQnt[indexL]
                            //             ['bookname']),
                            //       ],
                            //     ),
                            //   ),
                            // ),
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
