import 'package:flutter/material.dart';

class BackFloatingButton extends StatelessWidget {
  const BackFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.navigate_before),
    );
  }
}
