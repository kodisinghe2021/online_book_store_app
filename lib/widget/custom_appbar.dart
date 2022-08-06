
import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/user_provider.dart';
import 'package:online_book_store_app/widget/custom_dropdown_button.dart';
import 'package:online_book_store_app/widget/headings.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context);
    return AppBar(
      elevation: 20,
      backgroundColor: ConstantValues.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () {},
          icon: const CustomDropdownButton(),
        ),
      ),
      title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Heading01(text: 'Hi.. ${userData.userName}', fontSize: 30)),
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
