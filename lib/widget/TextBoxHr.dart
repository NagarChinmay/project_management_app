import 'package:flutter/material.dart';

class TextBoxHr extends StatefulWidget {
  const TextBoxHr({super.key, required this.label});
  final String label;
  @override
  State<TextBoxHr> createState() => _TextBoxHrState();
}

class _TextBoxHrState extends State<TextBoxHr> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 125,
      child: Card(
        child: Column(
          children: [
            Flexible(child: Align(
              alignment: Alignment.centerLeft,
              child: Text("data"),
            )),
            SizedBox(
              height: 40,
              child: TextField(decoration: InputDecoration(border: InputBorder.none)),
            )
          ],
        ),
      ),
    );
  }
}
