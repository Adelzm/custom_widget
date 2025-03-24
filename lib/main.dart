import 'package:custom_widget/widgets/labeled_divider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Widgets"),
        ),
        body: const Column(
          children: [
            LabeledDivider(
              label: "My Divider",
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
