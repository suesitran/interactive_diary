import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

part 'diary_content.dart';

class ContentCardView extends StatefulWidget {
  final String? text;
  final List<String>? images;
  final String displayName;
  final String photoUrl;
  final DateTime dateTime;

  ContentCardView(
      {required this.displayName,
      required this.photoUrl,
      required this.dateTime,
      this.text,
      this.images,
      Key? key})
      : assert(text != null || images?.isNotEmpty == true,
            'Need either text or image list to be displayed'),
        super(key: key);

  @override
  State<ContentCardView> createState() => _ContentCardViewState();
}

class _ContentCardViewState extends State<ContentCardView> {
  String dateFormat = 'dd MMM, yyyy';
  String timeFormat = 'HH:mm a';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: NartusDimens.padding16,
        right: NartusDimens.padding16,
        bottom: NartusDimens.padding16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DiaryHeaderAppbar(
            icon: Assets.images.idMoreIcon,
            semanticsIcon: S.current.toolbarMore,
            avatarPath: widget.photoUrl,
            displayName: widget.displayName,
            dateTime: S.current.diaryDateFormatter(
                DateFormat(dateFormat).format(widget.dateTime),
                DateFormat(timeFormat).format(widget.dateTime)),
          ),
          _DiaryContent(
            text: widget.text,
            images: widget.images,
          ),
          const Divider(
            color: NartusColor.semiLightGrey,
            height: 1,
          )
        ],
      ),
    );
  }
}
