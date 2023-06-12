import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_display_content_cubit.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/utils/date_utils.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';

class PictureDiaryDetailScreen extends StatelessWidget {
  final int dateTime;
  final String countryCode;
  final String postalCode;

  const PictureDiaryDetailScreen(
      {required this.dateTime,
      required this.countryCode,
      required this.postalCode,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryDisplayContentCubit>(
      create: (context) =>
          DiaryDisplayContentCubit()..fetchDiaryDisplayContent(dateTime, countryCode, postalCode),
      child: BlocBuilder<DiaryDisplayContentCubit, DiaryDisplayContentState>(
        builder: (context, state) {
          if (state is DiaryDisplayContentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DiaryDisplayContentNotFound) {
            return Container(); // todo update
          } else {
            final content = (state as DiaryDisplayContentSuccess).content;
            return Stack(
              children: [
                // Display the image
                Image.file(
                  File(content.imageUrl.single),
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
                              avatarPath: content.userPhotoUrl,
                              displayName: content.userDisplayName,
                              dateTime: S.current.diaryDateFormatter(
                                IDDateUtils.dateFormatDDMMMYYYY(content.dateTime),
                                IDDateUtils.dateFormatHHMMA(content.dateTime),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }
        },
      ),
    );
  }

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
