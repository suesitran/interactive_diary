import 'package:flutter/material.dart';

class IDWriteDiary extends StatefulWidget {
  const IDWriteDiary({super.key});

  @override
  State<StatefulWidget> createState() => _IDWriteDiaryState();
}

class _IDWriteDiaryState extends State<IDWriteDiary> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add text',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add text'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}