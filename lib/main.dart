import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.green,
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _openTextFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'text',
      extensions: <String>['txt', 'html'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;

    final String fileName = file.name;
    final String fileContent = await file.readAsString();

    print(fileName);
    print(fileContent);
  }

  Future<void> _saveTextFile() async {
    final String fileName = _nameController.text;

    final String? path = await getSavePath(suggestedName: fileName);

    if (path == null) return;

    final String text = _contentController.text;
    final Uint8List fileData = Uint8List.fromList(utf8.encode(text));
    const String fileMimeType = 'text/plain';
    final XFile textFile =
        XFile.fromData(fileData, mimeType: fileMimeType, name: fileName);

    await textFile.saveTo(path);
  }

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
            ElevatedButton(
                onPressed: () => _openTextFile(context),
                child: const Text('Select a file')),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: TextField(
                minLines: 1,
                maxLines: 12,
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: '(Optional) Suggest File Name',
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                minLines: 1,
                maxLines: 12,
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Enter File Contents',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => _saveTextFile(),
                child: const Text('Save a file')),
          ],
        ),
      ),
    );
  }

  // void openFile(PlatformFile file) {
  //   OpenFile(file.path!);
  // }
}
