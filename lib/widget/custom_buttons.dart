import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(primary: ConstantValues.primaryColor),
      onPressed: onTap,
      child: Text(text),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ConstantValues.secondryColor, //ConstantValues.primaryColor,
        animationDuration: const Duration(milliseconds: 3000),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
      onPressed: onTap,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5.5,
            ))
          : Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
    );
  }
}
