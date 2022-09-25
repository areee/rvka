import 'package:flutter/material.dart';

class SelectedItemListTiles extends StatelessWidget {
  const SelectedItemListTiles({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.changeSelectedItem,
  });

  final List<String>? items;
  final String? selectedItem;
  final Function(String?) changeSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final String item in items!)
          SizedBox(
            width: 160,
            child: ListTile(
              title: Text(item),
              leading: Radio<String>(
                value: item,
                groupValue: selectedItem,
                onChanged: changeSelectedItem,
              ),
            ),
          ),
      ],
    );
  }
}
