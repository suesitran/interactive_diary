import 'package:flutter/material.dart';
import 'package:interactive_diary/features/writediary/location.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/generated/l10n.dart';

class IDWriteDiary extends StatefulWidget {
  const IDWriteDiary({super.key});

  @override
  State<StatefulWidget> createState() => _IDWriteDiaryState();
}

class _IDWriteDiaryState extends State<IDWriteDiary> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S.of(context).addText,
      home: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).addText,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: NartusColor.dark)),
          backgroundColor: NartusColor.background,
          leading: const BackButton(
            color: NartusColor.backButtonColor,
          ),
          actions: <Widget>[
            NartusButton.text(onPressed: () {}, label: S.of(context).save),
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const LocationView(currentLocation: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: true,
              showCursor: true,
              maxLines: null,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.bodyText2,
              keyboardType: TextInputType.multiline,
            ),
          ))
        ]),
      ),
    );
  }
}
