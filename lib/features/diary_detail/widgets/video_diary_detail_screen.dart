import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:video_player/video_player.dart';

import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';

class VideoDiaryDetailScreen extends StatelessWidget {
  final String videoPath;
  final String? displayName;
  final String? photoUrl;
  final DateTime dateTime;

  const VideoDiaryDetailScreen({required this.videoPath, required this.displayName, required this.photoUrl, required this.dateTime, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      // Display the image
      VideoPlayUI(path: videoPath),
      Positioned(
        top: NartusDimens.padding52,
        left: NartusDimens.padding16,
        child: CircleButton(
          size: NartusDimens.padding40,
          iconPath: Assets.images.closeIcon,
          semantic: S.current.close,
          onPressed: () => context.pop(),
        ),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
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
}

class VideoPlayUI extends StatefulWidget {
  final String path;
  const VideoPlayUI({required this.path, Key? key}) : super(key: key);

  @override
  State<VideoPlayUI> createState() => _VideoPlayUIState();
}

class _VideoPlayUIState extends State<VideoPlayUI> {

  late final VideoPlayerController _controller = VideoPlayerController.file(File(widget.path));

  @override
  void initState() {
    super.initState();

    _initVideoController();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ValueListenableBuilder<VideoPlayerValue>(valueListenable: _controller, builder: (context, value, child) => value.isInitialized ? VideoPlayer(_controller) : const Center(
        child: CircularProgressIndicator(),
      ),),
      Center(
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller,
          builder: (context, value, child) => Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(NartusDimens.radius56),
              child: SvgPicture.asset(value.isPlaying ? Assets.icon.pause : Assets.icon.play, semanticsLabel: value.isPlaying ? S.current.pause : S.current.play, width: NartusDimens.radius56, height: NartusDimens.radius56,),
              onTap: () {
                if (value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
            ),
          ),
        ),
      )
    ],
  );

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _initVideoController() async {
    await _controller.initialize();

    _controller.addListener(() {
      // TODO add listener to start animation on Play/Pause button
    });
  }
}
