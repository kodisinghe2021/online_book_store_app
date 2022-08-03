import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';

class BottomWave extends StatelessWidget {
  const BottomWave({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: screenSize.height * 0.4,
        width: screenSize.width,
        child: Image.asset(
          'assets/images/btmwave.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
    required this.screenSize,
    this.heightMinimizingValue = 0.3,
  }) : super(key: key);

  final Size screenSize;
  final double heightMinimizingValue;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * heightMinimizingValue,
        decoration: const BoxDecoration(
          color: ConstantValues.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
        ),
      ),
    );
  }
}
