import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/provider/book_provider.dart';
import 'package:online_book_store_app/screens/admin_panel/admin_dashboard.dart';
import 'package:online_book_store_app/screens/home_screens/product_view_screen.dart';
import 'package:online_book_store_app/screens/login_screen/login_screen.dart';
import 'package:online_book_store_app/screens/login_screen/registration_page.dart';
import 'package:online_book_store_app/screens/menu_screens/custom_feedback_screen.dart';
import 'package:online_book_store_app/screens/menu_screens/forum_screen.dart';
import 'package:online_book_store_app/screens/menu_screens/profile_screen.dart';
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
        ChangeNotifierProvider(create: (context) => BooksProvider(),
        ),
      ],
      // providers:[ChangeNotifierProvider( (context) => UserProvider()),],
      child: MaterialApp(
        routes: {
          LoginScreen.pageKey: (context) => const LoginScreen(),
          RegistrationScreen.pageKey: (context) => const RegistrationScreen(),
          ProductViewScreen.pageKey: (context) => const ProductViewScreen(),
          CustomFeedBackScreen.pageKey: (context) =>
              const CustomFeedBackScreen(),
          ProfileScreen.pageKey: (context) => const ProfileScreen(),
          ForumScreen.pageKey: (context) => const ForumScreen(),
          AdminDashBoard.pageKey:(context) => AdminDashBoard(),
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
