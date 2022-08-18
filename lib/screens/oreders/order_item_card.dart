import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_book_store_app/provider/orders.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final OrderItemModal orderItem;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool _isExpandard = false;
  @override
  Widget build(BuildContext context) {
    final cartItemList = widget.orderItem.bookItems;
    return Column(
      children: [
        Card(
          child: ListTile(
            isThreeLine: true,
            leading: Text('එකතුව: ${widget.orderItem.totalAmount}'),
            subtitle: Text(
                'දිනය: ${DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.dateTime)}'),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _isExpandard = !_isExpandard;
                });
              },
              icon: Icon(_isExpandard ? Icons.expand_less : Icons.expand_more),
            ),
          ),
        ),
        if (_isExpandard)
          SizedBox(
            height: min(cartItemList.length * 20 + 100, 180),
            child: ListView.builder(
              itemCount: cartItemList.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$index - ${cartItemList[index].title}'),
                      Text('Rs: ${cartItemList[index].price}.00'),
                      Text(cartItemList[index].quantity),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
