import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';

class TextDiaryDetailScreen extends StatelessWidget {
  final String jsonText;
  final String? photoUrl;
  final String? displayName;
  final DateTime dateTime;

  const TextDiaryDetailScreen(
      {required this.jsonText,
      required this.photoUrl,
      required this.displayName,
      required this.dateTime,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final json = jsonDecode(jsonText);
    Document? document = Document.fromJson(json);
    QuillController richText = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ActivityFeedCard(
          dateTime: S.current.diaryDateFormatter(dateTime, dateTime),
          avatarPath: photoUrl,
          displayName: displayName,
          padding: EdgeInsets.zero,
          displayNameColor: Theme.of(context).colorScheme.onBackground,
        ),
        backgroundColor: NartusColor.background,
        leading: NartusButton.icon(
          iconPath: Assets.images.back,
          iconSemanticLabel: S.of(context).back,
          onPressed: () {
            _returnToPreviousPage(context);
          },
          iconColor: Theme.of(context).colorScheme.onBackground,
          sizeType: SizeType.tiny,
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
