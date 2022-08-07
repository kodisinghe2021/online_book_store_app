import 'package:flutter/material.dart';


class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);
  static const pageKey = '/admin-dashboard';
  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.amber,
        child: const Center(child: Text("Admin")),
      ),
    );
  }
}
