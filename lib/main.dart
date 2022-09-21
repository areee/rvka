import 'package:file_selector/file_selector.dart';
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
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
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
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _contentController = TextEditingController();

  String _textFilePath = "A text file path goes here";
  String _htmlFilePath = "An HTML file path goes here";

  Future<void> _openTextFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'text',
      extensions: <String>['txt'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;

    final String filePath = file.path;

    setState(() {
      _textFilePath = filePath;
    });
  }

  Future<void> _openHtmlFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'HTML',
      extensions: <String>['html'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;

    final String filePath = file.path;

    setState(() {
      _htmlFilePath = filePath;
    });
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
            // const Text(
            //   'Select a web store',
            //   style: TextStyle(fontSize: 20),
            // ),
            // TODO: Add two radio buttons for selecting the web store
            // const SizedBox(height: 10),
            const Text(
              'Select a text file',
              style: TextStyle(fontSize: 20),
            ),
            TextAndButton(
              text: _textFilePath,
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
              buttonText: 'Open HTML file',
              onPressed: () => _openHtmlFile(context),
            ),
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

class TextAndButton extends StatelessWidget {
  const TextAndButton(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.onPressed});

  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(text),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 40),
            ),
            onPressed: onPressed,
            // Align text to center

            child: Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
