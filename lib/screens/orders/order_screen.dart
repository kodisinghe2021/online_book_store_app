// import 'package:flutter/material.dart';
// import 'package:online_book_store_app/provider/orders_provider.dart';
// import 'package:online_book_store_app/screens/orders/order_item_card.dart';
// import 'package:online_book_store_app/widget/app_drawer.dart';
// import 'package:online_book_store_app/widget/black_floating_button.dart';
// import 'package:online_book_store_app/widget/custom_appbar.dart';
// import 'package:provider/provider.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({Key? key}) : super(key: key);
//   static const pageKey = '/order-screen';
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final order = Provider.of<OrderItemProvider>(context);
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: const BackFloatingButton(),
//         appBar: const CustomAppBar(
//           text: 'My Book Order',
//           fontSize: 20,
//         ),
//         drawer: AppDrawer(),
//         body: Align(
//           alignment: Alignment.bottomCenter,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 Container(
//                   width: screenSize.width,
//                   height: screenSize.height * 0.85,
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 212, 220, 217),
//                   ),
//                   child: ListView.builder(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 20),
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: order.itemCount,
//                       itemBuilder: (context, index) {
//                         return OrderItemCard(
//                             orderItem: order.getOrderItem[index]);
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
