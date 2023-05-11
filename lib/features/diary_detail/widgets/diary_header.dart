import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class DiaryHeaderAppbar extends StatelessWidget {
  final String avatarPath;
  final String displayName;
  final DateTime dateTime;
  final String dateFormat = 'dd MMM, yyyy';
  final String timeFormat = 'HH:mm a';

  const DiaryHeaderAppbar(
      {required this.avatarPath,
      required this.displayName,
      required this.dateTime,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: NartusDimens.padding8),
        child: MergeSemantics(
          child: Row(
            children: [
              // TODO change avatar to be a thumbnail downloaded and store in cached file
              ExcludeSemantics(
                child: CircleAvatar(
                  radius: NartusDimens.radius16,
                  backgroundImage: NetworkImage(avatarPath),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: NartusDimens.padding10,
                    right: NartusDimens.padding10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: Theme.of(context).textTheme.titleSmall,
                      semanticsLabel: displayName,
                    ),
                    Text(
                      S.current.diaryDateFormatter(
                          DateFormat(dateFormat).format(dateTime),
                          DateFormat(timeFormat).format(dateTime)),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: NartusColor.grey, height: 1.5),
                    )
                  ],
                ),
              )),
              SvgPicture.asset(
                Assets.images.idMoreIcon,
                semanticsLabel: S.current.toolbarMore,
                colorFilter:
                    const ColorFilter.mode(NartusColor.grey, BlendMode.srcIn),
              )
            ],
          ),
        ),
      );
}
