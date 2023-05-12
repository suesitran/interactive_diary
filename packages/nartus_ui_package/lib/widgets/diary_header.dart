import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class DiaryHeaderAppbar extends StatelessWidget {
  final String avatarPath;
  final String displayName;
  final String dateTime;
  final String? semanticsIcon;
  final String icon;

  const DiaryHeaderAppbar(
      {required this.avatarPath,
      required this.displayName,
      required this.dateTime,
      required this.icon,
      this.semanticsIcon,
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
                      dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: NartusColor.grey, height: 1.5),
                    )
                  ],
                ),
              )),
              SvgPicture.asset(
                icon,
                semanticsLabel: semanticsIcon,
                colorFilter:
                    const ColorFilter.mode(NartusColor.grey, BlendMode.srcIn),
              )
            ],
          ),
        ),
      );
}
