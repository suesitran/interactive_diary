import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'diary_header.dart';
part 'diary_content.dart';

class ContentCardView extends StatefulWidget {
  final String? text;
  final List<String>? images;
  final String displayName;
  final String photoUrl;
  final DateTime dateTime;

  ContentCardView({required this.displayName, required this.photoUrl, required this.dateTime, this.text, this.images, Key? key})
      : assert(text != null || images?.isNotEmpty == true,
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
          bottom: NartusDimens.padding16,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DiaryHeader(
            avatarPath: widget.photoUrl,
            displayName: widget.displayName,
            dateTime: widget.dateTime,
          ),
          _DiaryContent(
            text: widget.text,
            images: widget.images,
          ),
          const Divider(
            color: NartusColor.lightGrey,
            height: 1,
          )
        ],
      ),
    );
  }
}
