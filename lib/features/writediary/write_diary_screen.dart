import 'package:flutter/material.dart';
import 'package:interactive_diary/features/writediary/location.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/generated/l10n.dart';

class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  final TextEditingController textEditingController = TextEditingController();
  String content = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    content = '';
  }

  void _onEditTextChange(String text) {
    setState(() {
      content = text;
    });
  }

  void _onSavePressed() {}

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
      child: Scaffold(
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
            NartusButton.text(
                onPressed: textEditingController.text.isNotEmpty
                    ? _onSavePressed
                    : null,
                label: S.of(context).save),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LocationView(
                  currentLocation:
                      'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia'),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textEditingController,
                  onChanged: (String text) {
                    _onEditTextChange(text);
                  },
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
