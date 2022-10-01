import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rvka/utils/selected_file_format_helper.dart';
import 'package:rvka/utils/selected_shop_helper.dart';
import 'package:rvka/widgets/selected_item_list_tiles.dart';
import 'package:rvka/widgets/text_and_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RVKA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFF4CAF50),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF4CAF50),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'RVKA - Ruokaverkkokaupan apuri'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _contentController = TextEditingController();

  String? _textFilePath;
  String? _htmlFilePath;

  String? _selectedShop = SelectedShop.sKaupat.value;
  final List<String> _shops = SelectedShop.values.map((e) => e.value).toList();

  String? _selectedFileFormat = SelectedFileFormat.excel.value;
  final List<String> _fileFormats =
      SelectedFileFormat.values.map((e) => e.value).toList();

  Future<void> _openTextFile(BuildContext context) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'text',
      extensions: <String>['txt'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;

    String filePath;
    if (kIsWeb) {
      filePath = file.name;
    } else {
      filePath = file.path;
    }

    setState(() {
      _textFilePath = filePath;
    });
  }

  Future<void> _openHtmlFile(BuildContext context) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'HTML',
      extensions: <String>['html'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;

    String filePath;
    if (kIsWeb) {
      filePath = file.name;
    } else {
      filePath = file.path;
    }

    setState(() {
      _htmlFilePath = filePath;
    });
  }

  void _changeSelectedShop(String? value) {
    setState(() {
      _selectedShop = value;
    });
  }

  void _changeSelectedFileFormat(String? value) {
    setState(() {
      _selectedFileFormat = value;
    });
  }

  Future<String?> _showInformationDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Selections you made'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Selected shop:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("$_selectedShop"),
            _selectedShop == SelectedShop.sKaupat.value
                ? const Text("Selected file format:",
                    style: TextStyle(fontWeight: FontWeight.bold))
                : const SizedBox.shrink(),
            _selectedShop == SelectedShop.sKaupat.value
                ? _textFilePath == null
                    ? const Text('Not set')
                    : Text(_textFilePath!)
                : const SizedBox.shrink(),
            const Text("HTML file path:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            _htmlFilePath == null
                ? const Text('Not set')
                : Text(_htmlFilePath!),
            const Text("Selected file format:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("$_selectedFileFormat"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Future<void> _saveTextFile() async {
  //   final String fileName = _nameController.text;

  //   final String? path = await getSavePath(suggestedName: fileName);

  //   if (path == null) return;

  //   final String text = _contentController.text;
  //   final Uint8List fileData = Uint8List.fromList(utf8.encode(text));
  //   const String fileMimeType = 'text/plain';
  //   final XFile textFile =
  //       XFile.fromData(fileData, mimeType: fileMimeType, name: fileName);

  //   await textFile.saveTo(path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select a web store',
              style: TextStyle(fontSize: 20),
            ),
            SelectedItemListTiles(
              items: _shops,
              selectedItem: _selectedShop,
              changeSelectedItem: _changeSelectedShop,
            ),
            const SizedBox(height: 10),
            if (_selectedShop == SelectedShop.sKaupat.value)
              const Text(
                'Select a text file',
                style: TextStyle(fontSize: 20),
              ),
            if (_selectedShop == SelectedShop.sKaupat.value)
              TextAndButton(
                text: _textFilePath,
                textDescription: 'A text',
                buttonText: 'Open text file',
                onPressed: () => _openTextFile(context),
              ),
            const SizedBox(height: 10),
            const Text(
              'Select a HTML file',
              style: TextStyle(fontSize: 20),
            ),
            TextAndButton(
              text: _htmlFilePath,
              textDescription: 'An HTML',
              buttonText: 'Open HTML file',
              onPressed: () => _openHtmlFile(context),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select an ouput file format',
              style: TextStyle(fontSize: 20),
            ),
            SelectedItemListTiles(
              items: _fileFormats,
              selectedItem: _selectedFileFormat,
              changeSelectedItem: _changeSelectedFileFormat,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 40),
              ),
              onPressed: () => _showInformationDialog(context),
              child: const Text('Run'),
            ),
            // ====
            // Text('Selected text file: $_textFilePath'),
            // ElevatedButton(
            //     onPressed: () => _openTextFile(context),
            //     child: const Text('Select a file')),
            // =====
            // const SizedBox(height: 10),
            // SizedBox(
            //   width: 300,
            //   child: TextField(
            //     minLines: 1,
            //     maxLines: 12,
            //     controller: _nameController,
            //     decoration: const InputDecoration(
            //       hintText: '(Optional) Suggest File Name',
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 300,
            //   child: TextField(
            //     minLines: 1,
            //     maxLines: 12,
            //     controller: _contentController,
            //     decoration: const InputDecoration(
            //       hintText: 'Enter File Contents',
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // ElevatedButton(
            //     onPressed: () => _saveTextFile(),
            //     child: const Text('Save a file')),
          ],
        ),
      ),
    );
  }
}
