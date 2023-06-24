import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class User {
  final String? displayName;
  final String? photoURL;

  const User({
    this.displayName,
    this.photoURL,
  });
}

class AuthenticationService {
  User? getCurrentUser() {
    // Replace with authentication logic ???
    return User(
      displayName: 'STATIC',
      photoURL:
          'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c',
    );
  }
}

class ActivityFeedCard extends StatelessWidget {
  final bool isLoggedIn;
  final String? avatarPath;
  final String? displayName;
  final String dateTime;
  final String? privacyIcon;
  final String? semanticsPrivacyIcon;

  const ActivityFeedCard({
    required this.dateTime,
    required this.isLoggedIn,
    this.avatarPath,
    this.displayName,
    this.privacyIcon,
    this.semanticsPrivacyIcon,
    Key? key,
  }) : super(key: key);

  factory ActivityFeedCard.fromAuthenticationService({
    required String dateTime,
    required AuthenticationService authService,
    Key? key,
  }) {
    return ActivityFeedCard(
      key: key,
      dateTime: dateTime,
      isLoggedIn: authService.getCurrentUser() != null,
      avatarPath: authService.getCurrentUser()?.photoURL,
      displayName: authService.getCurrentUser()?.displayName,
      privacyIcon: 'assets/icons/lock.svg',
      semanticsPrivacyIcon: 'Private',
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultAvatarPath = 'assets/images/guest.svg';
    final defaultDisplayName = 'Guest';

    final userPhoto =
        isLoggedIn ? avatarPath ?? defaultAvatarPath : defaultAvatarPath;
    final userDisplayName =
        isLoggedIn ? displayName ?? defaultDisplayName : defaultDisplayName;

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
                      semanticsLabel: displayName ?? defaultDisplayName,
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
                          width: NartusDimens.radius32,
                          height: NartusDimens.radius32,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: NartusColor.grey, // Set the desired color
                          ),
                        ),
                        if (privacyIcon != null)
                          SvgPicture.asset(
                            privacyIcon!,
                            semanticsLabel: semanticsPrivacyIcon ??
                                'Private', // use a default label if none is provided
                            colorFilter: const ColorFilter.mode(
                                NartusColor.grey, BlendMode.srcIn),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
