import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'diary_header.dart';

class ContentCardAppBarView extends StatefulWidget {
  final String displayName;
  final String photoUrl;
  final DateTime dateTime;

  const ContentCardAppBarView(
      {required this.displayName,
      required this.photoUrl,
      required this.dateTime,
      Key? key})
      : super(key: key);

  @override
  State<ContentCardAppBarView> createState() => _ContentCardAppBarViewState();
}

class _ContentCardAppBarViewState extends State<ContentCardAppBarView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: NartusDimens.padding16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DiaryHeaderAppbar(
            avatarPath: widget.photoUrl,
            displayName: widget.displayName,
            dateTime: widget.dateTime,
          ),
        ],
      ),
    );
  }
}
