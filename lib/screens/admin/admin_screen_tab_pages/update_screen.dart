import 'package:flutter/material.dart';

class UpadateScreen extends StatelessWidget {
  const UpadateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.blueAccent,
        child: const Center(child: Text('class UpadateScreen')),
      ),
    );
  }
}
