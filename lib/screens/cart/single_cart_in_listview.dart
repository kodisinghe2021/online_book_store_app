import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:provider/provider.dart';

class SingleCardInListView extends StatelessWidget {
  const SingleCardInListView({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  final bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemProvider>(context);
    CartItemModal bookitem = cart.cartItemMap.values.toList()[index];
    int totalOfBook = int.parse(bookitem.quantity) * int.parse(bookitem.price);
    return GestureDetector(
      onLongPress: () => Logger().w('Long Press $index'),
      child: Card(
        child: ListTile(
          isThreeLine: true,
          leading: Text('රු:${bookitem.price}.00'),
          title: Text(bookitem.title),
          subtitle: Text('Quantity: ${bookitem.quantity}'),
          trailing: Text(
            ('එකතුව $totalOfBook.00'),
          ),
        ),
      ),
    );
  }
}

class UDPanelForListTile extends StatelessWidget {
  const UDPanelForListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      color: Colors.amber.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
          ),
          const Text("Delete"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.change_circle,
              size: 30,
            ),
          ),
          const Text("Update"),
        ],
      ),
    );
  }
}
