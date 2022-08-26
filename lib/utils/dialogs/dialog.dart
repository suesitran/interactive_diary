import 'package:flutter/material.dart';

class DialogRequest extends StatefulWidget {
  @override
  _DialogRequestState createState() => _DialogRequestState();
  int? typeDialog = 0;
  DialogRequest({Key? key, required this.typeDialog}) : super(key: key);
}

class _DialogRequestState extends State<DialogRequest> {
  bool allow = false;
  @override
  Widget build(BuildContext context) {
    switch (widget.typeDialog) {
      case 0:
        return AlertDialog(
          title: const Text('Location Permission not granted'),
          content: const Text(
              'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Allow'),
              onPressed: () async {
                allow = true;
                Navigator.of(context, rootNavigator: true).pop(allow);
              },
            ),
            FlatButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                debugPrint('Location Denied once');
              },
            ),
          ],
        );
      case 1:
        return AlertDialog(
          title: const Text('Location Permission is needed to use this app'),
          content: const Text(
              'Explain why Location Permission is needed to use in this app.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Allow'),
              onPressed: () async {
                allow = true;
                Navigator.of(context, rootNavigator: true).pop(allow);
              },
            ),
          ],
        );

      default:
        break;
    }
    return Center();
  }
}
