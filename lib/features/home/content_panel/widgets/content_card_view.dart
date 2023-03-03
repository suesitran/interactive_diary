import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'diary_header.dart';
part 'diary_content.dart';

class ContentCardView extends StatefulWidget {
  final String? text;
  final List<String>? images;

  ContentCardView({this.text, this.images, Key? key})
      : assert(text != null || images?.isNotEmpty == true,
            'Need either text or image list to be displayed'),
        super(key: key);

  @override
  State<ContentCardView> createState() => _ContentCardViewState();
}

class _ContentCardViewState extends State<ContentCardView> {

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: NartusDimens.padding16,
          right: NartusDimens.radius16,
          bottom: NartusDimens.radius16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DiaryHeader(
            avatarPath:
                'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c',
            displayName: 'Hoang Nguyen',
            dateTime: DateTime(2022, 09, 03, 22, 12),
          ),
          _DiaryContent(
            text: widget.text,
            images: widget.images,
          )
        ],
      ),
    );
  }
}
