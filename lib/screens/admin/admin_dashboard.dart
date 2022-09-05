import 'package:flutter/material.dart';
import 'package:online_book_store_app/screens/admin/admin_screen_tab_pages/order_review_screen.dart';
import 'package:online_book_store_app/screens/admin/admin_screen_tab_pages/upload_screen.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);
  static String pageKey = '/admin-screen';
  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard>
    with SingleTickerProviderStateMixin {
//############################################################################//
  late TabController _tabController;
//############################################################################//
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      setState(() {});
    });
  }

//############################################################################//
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//############################################################################//
  List<String> pageTitles = [
    'Uploads',
    // 'Updates',
    'Orders',
  ];
//############################################################################//
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(pageTitles[_tabController.index]),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: pageTitles[0],
                icon: const Icon(Icons.upload_file),
              ),
              // Tab(
              //   text: pageTitles[1],
              //   icon: const Icon(Icons.upgrade),
              // ),
              Tab(
                text: pageTitles[1],
                icon: const Icon(Icons.shopping_cart_checkout),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            UploadScreen(),
            // UpadateScreen(),
            OrderReviewScreen(),
          ],
        ),
      ),
    );
  }
}
