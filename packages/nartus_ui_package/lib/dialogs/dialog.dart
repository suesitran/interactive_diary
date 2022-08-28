library DialogRequest;

import 'package:flutter/material.dart';

class DialogRequest extends StatefulWidget {
  @override
  _DialogRequestState createState() => _DialogRequestState();
  final String title;
  final String content;
  final String primaryButtonTitle;
  final String secondaryButtonTitle;
  void Function()? primaryButtonPress;
  void Function()? secondaryButtonPress;

  DialogRequest(
      {Key? key,
      required this.title,
      required this.content,
      required this.primaryButtonTitle,
      required this.secondaryButtonTitle,
      required this.primaryButtonPress,
      required this.secondaryButtonPress})
      : super(key: key);
}

class _DialogRequestState extends State<DialogRequest> {
  bool allow = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: <Widget>[
        FlatButton(
            onPressed: widget.primaryButtonPress,
            child: Text(widget.primaryButtonTitle)),
        Visibility(
          visible: widget.secondaryButtonTitle == '' ? false : true,
          child: FlatButton(
              onPressed: widget.secondaryButtonPress,
              child: Text(widget.secondaryButtonTitle)),
        )
      ],
    );
  }
}
