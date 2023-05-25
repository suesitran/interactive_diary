import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int timeStamp = 1683310211667;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    List<Map<String, Object>> textJson = [
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {'insert': '\n\n'},
      {
        'insert': 'Lorem ipsum dolor sit amet',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n'},
      {
        'insert':
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n\n'},
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {'insert': '\n\n'},
      {
        'insert': 'Lorem ipsum dolor sit amet',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n'},
      {
        'insert':
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
        'attributes': {'color': '#00eeff'}
      },
      {'insert': '\n\n'},
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {'insert': '\n\n'},
    ];

    String userDisplayName = 'Hoang Nguyen';
    String userPhotoUrl =
        'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';
    Document? document = Document.fromJson(textJson);
    QuillController richText = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0));
    String dateFormat = 'dd MMM, yyyy';
    String timeFormat = 'HH:mm a';
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: DiaryHeaderAppbar(
          icon: Assets.images.idMoreIcon,
          semanticsIcon: S.current.toolbarMore,
          avatarPath: userPhotoUrl,
          displayName: userDisplayName,
          dateTime: S.current.diaryDateFormatter(
              DateFormat(dateFormat).format(dateTime),
              DateFormat(timeFormat).format(dateTime)),
        ),
        backgroundColor: NartusColor.background,
        leading: NartusButton.text(
          iconPath: Assets.images.back,
          iconSemanticLabel: S.of(context).back,
          onPressed: () {
            _returnToPreviousPage(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: NartusDimens.padding16,
            right: NartusDimens.padding16,
            bottom: NartusDimens.padding16),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Semantics(
            child: QuillEditor(
              padding: EdgeInsets.zero,
              controller: richText,
              readOnly: true,
              autoFocus: true,
              expands: false,
              scrollable: true,
              focusNode: FocusNode()..canRequestFocus = false,
              scrollController: ScrollController(),
              enableInteractiveSelection: false,
              enableSelectionToolbar: false,
            ),
          ),
        ),
      ),
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
