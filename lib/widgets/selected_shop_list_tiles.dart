import 'package:flutter/material.dart';
import 'package:rvka/utils/selected_shop_helper.dart';

class SelectedShopListTiles extends StatelessWidget {
  const SelectedShopListTiles({
    super.key,
    required this.selectedShop,
    required this.changeSelectedShop,
  });

  final SelectedShop? selectedShop;
  final void Function(SelectedShop?)? changeSelectedShop;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: ListTile(
              title: Text(SelectedShop.sKaupat.value),
              leading: Radio<SelectedShop>(
                value: SelectedShop.sKaupat,
                groupValue: selectedShop,
                onChanged: changeSelectedShop,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: ListTile(
              title: Text(SelectedShop.kRuoka.value),
              leading: Radio<SelectedShop>(
                value: SelectedShop.kRuoka,
                groupValue: selectedShop,
                onChanged: changeSelectedShop,
              ),
            ),
          ),
        ]);
  }
}
