import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/screens/admin/admin_dashboard.dart';
import 'package:online_book_store_app/widget/cart_icon.dart';
import 'package:online_book_store_app/widget/custom_dropdown_button.dart';
import 'package:online_book_store_app/widget/headings.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.text = '',
    this.fontSize = 25,
  }) : super(key: key);
//############################################################################//
  final String text;
  final double fontSize;
//############################################################################//
  @override
  Size get preferredSize => const Size.fromHeight(55);
//############################################################################//

//############################################################################//
  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<UserAuthController>(context).checkAdministrator;
    return AppBar(
      elevation: 5,
      backgroundColor: ConstantValues.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(onPressed: () {}, icon: const CustomDropdownButton()),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Heading01(text: text, fontSize: fontSize),
      ),
      actions: [
        isAdmin
            ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminDashBoard.pageKey);
                },
                icon: const Icon(Icons.dashboard),
              )
            : Consumer<CartItemProvider>(
                builder: (context, value, child) {
                  return CartIcon(value: value.totalBooks.toString());
                },
              ),

        // CartIcon(),
      ],
    );
  }
}
