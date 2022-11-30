import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

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
          title: Text('Add text',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: NartusColor.dark)),
          backgroundColor: NartusColor.background,
          leading: const BackButton(
            color: NartusColor.backButtonColor,
          ),
          actions: [
            TextButton(
                onPressed: null,
                child: Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Text('Save',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: NartusColor.primary)),
                )),
          ],
        ),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              autofocus: true,
              showCursor: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          )
        ]),
      ),
    );
  }
}
