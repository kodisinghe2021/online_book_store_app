import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/provider/cart.dart';
import 'package:online_book_store_app/provider/order_provider.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/screens/admin/admin_dashboard.dart';
import 'package:online_book_store_app/screens/book_view/single_book_full_view.dart';
import 'package:online_book_store_app/screens/cart/cart_screen.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:online_book_store_app/screens/login/login_screen.dart';
import 'package:online_book_store_app/screens/login/registration_page.dart';
import 'package:online_book_store_app/screens/menu/custom_feedback_screen.dart';
import 'package:online_book_store_app/screens/menu/forum_screen.dart';
import 'package:online_book_store_app/screens/menu/profile_screen.dart';
import 'package:online_book_store_app/screens/orders/order_confirm_screen.dart';
import 'package:online_book_store_app/screens/orders/order_types/bank_deposit.dart';
import 'package:online_book_store_app/screens/orders/order_types/online_payment.dart';
import 'package:online_book_store_app/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BooksProvider()),
        ChangeNotifierProvider(create: (context) => CartItemProvider()),
        //   ChangeNotifierProvider(create: (context) => OrderItemProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserAuthController()),
      ],
      // providers:[ChangeNotifierProvider( (context) => UserProvider()),],
      child: MaterialApp(
        routes: {
          AdminDashBoard.pageKey: (context) => const AdminDashBoard(),
          LoginScreen.pageKey: (context) => const LoginScreen(),
          RegistrationScreen.pageKey: (context) => const RegistrationScreen(),
          ProductViewScreen.pageKey: (context) => const ProductViewScreen(),
          CustomFeedBackScreen.pageKey: (context) =>
              const CustomFeedBackScreen(),
          ProfileScreen.pageKey: (context) => const ProfileScreen(),
          ForumScreen.pageKey: (context) => const ForumScreen(),
          //AdminDashBoard.pageKey: (context) => const AdminDashBoard(),
          SingleBookFullViewScreen.pageKey: (context) =>
              const SingleBookFullViewScreen(),
          CartScreen.pageKey: (context) => const CartScreen(),
          // OrderScreen.pageKey: (context) => const OrderScreen(),
          OrdersConfirmScreen.pageKey: (context) => const OrdersConfirmScreen(),
          BankDiposit.pageKey: (context) => const BankDiposit(),
          OnlinePayment.pageKey: (context) => const OnlinePayment(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ConstantValues.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: const AppBarTheme(color: Color(0xFF06113C)),
        ),
        //theme stup
        title: 'title',
        themeMode: ThemeMode.system,

        home: const SplashScreen(),
      ),
    );
  }
}
