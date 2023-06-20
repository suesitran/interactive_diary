import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class ActivityFeedCard extends StatelessWidget {
  final String? avatarPath;
  final String? displayName;
  final String dateTime;
  final String? privacyIcon;
  final String? semanticsPrivacyIcon;

  const ActivityFeedCard(
      {required this.dateTime,
      this.avatarPath,
      this.displayName,
      this.privacyIcon,
      this.semanticsPrivacyIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultAvatarPath = 'https://lh3.googleusercontent.com/d/1_aTuBIour-Fn9jgj7bh1Y1P2PJja8dbD'; // Default avatar path
    const defaultDisplayName = 'Guest'; // Default display name

    final userPhoto = avatarPath ?? defaultAvatarPath;
    final userDisplayName = displayName ?? defaultDisplayName;

    return Padding(
      padding: const EdgeInsets.only(bottom: NartusDimens.padding8),
      child: MergeSemantics(
        child: Row(
          children: [
            // TODO change avatar to be a thumbnail downloaded and store in cached file
            ExcludeSemantics(
              child: CircleAvatar(
                radius: NartusDimens.radius16,
                backgroundImage: NetworkImage(userPhoto),
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
                        userDisplayName,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: NartusColor.semiLightGrey),
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
                          if (privacyIcon != null)
                            SvgPicture.asset(
                              privacyIcon!,
                              semanticsLabel: semanticsPrivacyIcon,
                              colorFilter: const ColorFilter.mode(
                                  NartusColor.grey, BlendMode.srcIn),
                            )
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
