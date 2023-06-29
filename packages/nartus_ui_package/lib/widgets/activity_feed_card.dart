import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class ActivityFeedCard extends StatelessWidget {
  final String defaultAvatarSvg =
      '''<svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle opacity="0.1" cx="20" cy="20" r="20" fill="#DCDCE1"/>
<path opacity="0.5" d="M20.0001 32.0166C26.6275 32.0166 32 26.6441 32 20.0167C32 13.3893 26.6275 8.01672 20.0001 8.01672C13.3727 8.01672 8.00012 13.3893 8.00012 20.0167C8.00012 26.6441 13.3727 32.0166 20.0001 32.0166Z" fill="#DCDCE1"/>
<path d="M20.0001 13.9327C17.5161 13.9327 15.5001 15.9487 15.5001 18.4327C15.5001 20.8687 17.4081 22.8487 19.9401 22.9207C19.9761 22.9207 20.0241 22.9207 20.0481 22.9207C20.0721 22.9207 20.1081 22.9207 20.1321 22.9207C20.1441 22.9207 20.1561 22.9207 20.1561 22.9207C22.5801 22.8367 24.4881 20.8687 24.5001 18.4327C24.5001 15.9487 22.4841 13.9327 20.0001 13.9327Z" fill="#6B727B"/>
<path d="M28.136 28.8366C26 30.8046 23.144 32.0166 20 32.0166C16.856 32.0166 14 30.8046 11.864 28.8366C12.152 27.7446 12.932 26.7486 14.072 25.9806C17.348 23.7967 22.676 23.7967 25.928 25.9806C27.08 26.7486 27.848 27.7446 28.136 28.8366Z" fill="#6B727B"/>
</svg>
''';
  final String? avatarPath;
  final String? displayName;
  final Color displayNameColor;
  final String dateTime;
  final String? privacyIcon;
  final String? semanticsPrivacyIcon;
  final EdgeInsets padding;

  const ActivityFeedCard(
      {required this.dateTime,
      this.avatarPath,
      this.displayName,
      this.privacyIcon,
      this.semanticsPrivacyIcon,
      this.displayNameColor = NartusColor.semiLightGrey,
      this.padding = const EdgeInsets.only(bottom: NartusDimens.padding8),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MergeSemantics(
        child: Row(
          children: [
            // TODO change avatar to be a thumbnail downloaded and store in cached file
            ExcludeSemantics(
              child: avatarPath == null || avatarPath?.isEmpty == true
                  ? SvgPicture.string(
                      defaultAvatarSvg,
                      width: 32,
                      height: 32,
                    )
                  : CircleAvatar(
                      radius: NartusDimens.radius16,
                      backgroundImage: NetworkImage(avatarPath!),
                    ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: NartusDimens.padding10, right: NartusDimens.padding10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName ?? Strings.current.guest,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: displayNameColor),
                    semanticsLabel: displayName,
                  ),
                  Row(
                    children: [
                      Text(
                        dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: NartusColor.grey, height: 1.5),
                      ),
                      if (privacyIcon != null) ...[
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: NartusDimens.padding4),
                          width: NartusDimens.radius3,
                          height: NartusDimens.radius3,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: NartusColor.grey, // Set the desired color
                          ),
                        ),
                        SvgPicture.asset(
                          privacyIcon!,
                          semanticsLabel: semanticsPrivacyIcon,
                          colorFilter: const ColorFilter.mode(
                              NartusColor.grey, BlendMode.srcIn),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
