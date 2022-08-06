import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:online_book_store_app/constant.dart';
import 'package:online_book_store_app/models/menu_item_modal.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.list,
          size: 46,
          color: Colors.white,
        ),
        customItemsIndexes: const [4],
        customItemsHeight: 12,
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItemC>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(
              enabled: true,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              )),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItemC>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItemC);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 170,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ConstantValues.secondryColor,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }
}
