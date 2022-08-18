import 'package:flutter/material.dart';
import 'package:online_book_store_app/controllers/user_auth_controller.dart';
import 'package:online_book_store_app/screens/admin/admin_dashboard.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/login/login_screen.dart';
import 'package:online_book_store_app/screens/menu/custom_feedback_screen.dart';
import 'package:online_book_store_app/screens/menu/profile_screen.dart';

class MenuItemC {
  final String text;
  final IconData icon;

  const MenuItemC({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItemC> firstItems = [home, profile, feedback, admin];
  static const List<MenuItemC> secondItems = [logout];

  static const home = MenuItemC(text: 'Products', icon: Icons.menu_book);
  static const profile = MenuItemC(text: 'Profile', icon: Icons.person);
  static const feedback = MenuItemC(text: 'Feedback', icon: Icons.feedback);

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~ this line changed for teting perpous~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  static const admin =
      MenuItemC(text: 'Admin', icon: Icons.admin_panel_settings); //forum
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~ this line changed for teting perpous~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

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
      case MenuItems.admin:
        Navigator.pushNamed(context, AdminDashBoard.pageKey);
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
