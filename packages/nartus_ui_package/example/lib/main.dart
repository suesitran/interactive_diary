import 'package:example/screens/text_and_error_label_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Widget catalog'),
        ),
        body: const WidgetCatalog(),
      ),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        background: Colors.white,
        onBackground: const Color(0xffFFF9ED),
        error: const Color(0xFF8B0101),
        onError: Colors.white,
      )),
    );
  }
}

class WidgetCatalog extends StatelessWidget {
  const WidgetCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          _buildWidgetTile('Text and error label', TextAndErrorLabelScreen()),
        ],
      );

  Widget _buildWidgetTile(String title, Widget catalogScreen) => Builder(
      builder: (context) => ListTile(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).dividerColor, width: 1.0)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          trailing: const Icon(Icons.arrow_right),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => catalogScreen)),
          title: Text(title)));
}
