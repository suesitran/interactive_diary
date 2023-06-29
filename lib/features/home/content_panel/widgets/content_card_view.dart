import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';

part 'diary_content.dart';

class ContentCardView extends StatefulWidget {
  final String? text;
  final List<MediaInfo>? mediaInfo;
  final String? displayName;
  final String? userPhotoUrl;
  final DateTime dateTime;

  ContentCardView(
      {required this.dateTime,
      this.displayName,
      this.userPhotoUrl,
      this.text,
      this.mediaInfo,
      Key? key})
      : assert(
            text != null || mediaInfo != null || mediaInfo?.isNotEmpty == true,
            'Need either text or image list to be displayed'),
        super(key: key);

  @override
  State<ContentCardView> createState() => _ContentCardViewState();
}

class _ContentCardViewState extends State<ContentCardView> {
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
          ActivityFeedCard(
            dateTime:
                S.current.diaryDateFormatter(widget.dateTime, widget.dateTime),
            displayName: widget.displayName,
            avatarPath: widget.userPhotoUrl,
          ),
          _DiaryContent(
            text: widget.text,
            mediaInfos: widget.mediaInfo,
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
