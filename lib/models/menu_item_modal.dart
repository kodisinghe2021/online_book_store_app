import 'package:flutter/material.dart';
import 'package:online_book_store_app/controllers/user_auth_controller.dart';
import 'package:online_book_store_app/screens/home_screens/product_view_screen.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/screens/menu_screens/custom_feedback_screen.dart';
import 'package:online_book_store_app/screens/menu_screens/forum_screen.dart';
import 'package:online_book_store_app/screens/menu_screens/profile_screen.dart';

class MenuItemC {
  final String text;
  final IconData icon;

  const MenuItemC({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItemC> firstItems = [home, profile, feedback, forum];
  static const List<MenuItemC> secondItems = [logout];

  static const home = MenuItemC(text: 'Products', icon: Icons.menu_book);
  static const profile = MenuItemC(text: 'Profile', icon: Icons.person);
  static const feedback = MenuItemC(text: 'Feedback', icon: Icons.feedback);
  static const forum = MenuItemC(text: 'Forum', icon: Icons.forum);
  static const logout = MenuItemC(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItemC item) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Icon(item.icon, color: Colors.white, size: 22),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static onChanged(BuildContext context, MenuItemC item) async {
    switch (item) {
      case MenuItems.home:
        Navigator.pushNamed(context, ProductViewScreen.pageKey);
        break;
      case MenuItems.profile:
        Navigator.pushNamed(context, ProfileScreen.pageKey);
        break;
      case MenuItems.forum:
        Navigator.pushNamed(context, ForumScreen.pageKey);
        break;
      case MenuItems.feedback:
        Navigator.pushNamed(context, CustomFeedBackScreen.pageKey);
        break;
      case MenuItems.logout:
        await UserAuthController().logOutUser().then(
              (value) =>
                  Navigator.popAndPushNamed(context, LoginScreen.pageKey),
            );
        break;
    }
  }
}
