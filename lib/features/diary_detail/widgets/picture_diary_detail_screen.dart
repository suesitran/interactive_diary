import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';

class PictureDiaryDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String? displayName;
  final String? photoUrl;
  final DateTime dateTime;

  const PictureDiaryDetailScreen(
      {required this.imageUrl,
      required this.displayName,
      required this.photoUrl,
      required this.dateTime,
      super.key});

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          // Display the image
          Image.file(
            File(imageUrl),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: NartusDimens.padding52,
            left: NartusDimens.padding16,
            child: CircleButton(
              size: NartusDimens.padding40,
              iconPath: Assets.images.closeIcon,
              semantic: S.current.close,
              onPressed: () => _closeScreen(context),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.black.withOpacity(1.0)
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          NartusDimens.padding16,
                          NartusDimens.padding16,
                          NartusDimens.padding16,
                          NartusDimens.padding40),
                      child: ActivityFeedCard(
                        privacyIcon: null, // todo update in the future
                        semanticsPrivacyIcon: '',
                        avatarPath: photoUrl,
                        displayName: displayName,
                        dateTime: S.current.diaryDateFormatter(
                          dateTime,
                          dateTime,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      );

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
