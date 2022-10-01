import 'package:flutter/material.dart';

class TextAndButton extends StatelessWidget {
  const TextAndButton(
      {super.key,
      required this.text,
      required this.textDescription,
      required this.buttonText,
      required this.onPressed});

  final String? text;
  final String textDescription;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Row(
        children: <Widget>[
          Expanded(
            child: text == null
                ? Text('$textDescription file path goes here')
                : Text(text!),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 40),
            ),
            onPressed: onPressed,
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
