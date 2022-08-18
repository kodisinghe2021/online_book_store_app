import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/provider/book_modal.dart';
import 'package:provider/provider.dart';

class FavoriteToggleIcon extends StatelessWidget {
  const FavoriteToggleIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BookModal>(context);
    return IconButton(
      onPressed: () {
        book.toggleFavorite();
        Logger().w('Clicked........... ${book.isFavorite}');
      },
      icon: book.isFavorite
          ? const Icon(
              Icons.favorite,
              size: 28,
              color: Colors.white,
            )
          : const Icon(
              Icons.favorite_border,
              size: 25,
              color: Colors.white,
            ),
    );
  }
}
