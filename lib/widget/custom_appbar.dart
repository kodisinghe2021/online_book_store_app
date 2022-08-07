import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/widget/custom_dropdown_button.dart';
import 'package:online_book_store_app/widget/headings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.text = ''}) : super(key: key);
  final String text;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 20,
      backgroundColor: ConstantValues.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(onPressed: () {}, icon: const CustomDropdownButton()),
      ),
      title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Heading01(text: text, fontSize: 25)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.search, size: 30),
          ),
        ),
      ],
    );
  }
}
