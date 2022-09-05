import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/controllers/orders_controller.dart';
import 'package:online_book_store_app/models/order_modal.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: OrderController().fetchOrderData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModal>> snapshot) {
          if (snapshot.hasData) {
            List<OrderModal>? order = snapshot.data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: order!.length,
              itemBuilder: (context, index) => Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Customer name: ${order[index].name}',
                        style: GoogleFonts.acme(
                          fontSize: 20,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )),
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
        });
  }
}
