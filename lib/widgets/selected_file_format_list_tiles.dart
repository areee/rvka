import 'package:flutter/material.dart';
import 'package:rvka/utils/selected_file_format_helper.dart';

class SelectedFileFormatListTiles extends StatelessWidget {
  const SelectedFileFormatListTiles({
    super.key,
    required this.selectedFileFormat,
    required this.changeSelectedFileFormat,
  });

  final SelectedFileFormat? selectedFileFormat;
  final void Function(SelectedFileFormat?)? changeSelectedFileFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: ListTile(
              title: Text(SelectedFileFormat.excel.value),
              leading: Radio<SelectedFileFormat>(
                value: SelectedFileFormat.excel,
                groupValue: selectedFileFormat,
                onChanged: changeSelectedFileFormat,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: ListTile(
              title: Text(SelectedFileFormat.csv.value),
              leading: Radio<SelectedFileFormat>(
                value: SelectedFileFormat.csv,
                groupValue: selectedFileFormat,
                onChanged: changeSelectedFileFormat,
              ),
            ),
          ),
        ]);
  }
}
