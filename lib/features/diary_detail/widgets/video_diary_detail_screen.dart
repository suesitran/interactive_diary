import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:video_player/video_player.dart';

import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';

class VideoDiaryDetailScreen extends StatefulWidget {
  final String videoPath;
  final String? displayName;
  final String? photoUrl;
  final DateTime dateTime;

  const VideoDiaryDetailScreen(
      {required this.videoPath,
      required this.displayName,
      required this.photoUrl,
      required this.dateTime,
      Key? key})
      : super(key: key);

  @override
  State<VideoDiaryDetailScreen> createState() => _VideoDiaryDetailScreenState();
}

class _VideoDiaryDetailScreenState extends State<VideoDiaryDetailScreen>
    with TickerProviderStateMixin {
  late final VideoPlayerController _controller =
      VideoPlayerController.file(File(widget.videoPath));

  late final AnimationController _animationController =
      AnimationController(vsync: this)
        ..duration = const Duration(milliseconds: 500);

  late final Animation<double> _fadeVideoController =
      Tween(begin: 1.0, end: 0.0).animate(_animationController);

  late final AnimationController _durationController =
      AnimationController(vsync: this)
        ..duration = const Duration(milliseconds: 0);

  @override
  void initState() {
    super.initState();

    _initVideoController();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onPlayButtonTapped(_controller.value.isPlaying),
        child: Stack(
          children: [
            // Display the image
            VideoPlayUI(
              videoPlayerController: _controller,
              fadeAnimation: _fadeVideoController,
            ),
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
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            NartusDimens.padding16,
                            NartusDimens.padding16,
                            NartusDimens.padding16,
                            NartusDimens.padding40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _controller,
                              builder: (context, value, child) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _createDuration(value.position),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: NartusColor.white
                                                .withOpacity(0.7)),
                                  ),
                                  Text(
                                    _createDuration(value.duration),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: NartusColor.white
                                                .withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                                animation: _durationController,
                                builder: (context, child) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: NartusDimens.padding12),
                                      height: 2,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                NartusDimens.radius10)),
                                        child: ValueListenableBuilder<
                                            VideoPlayerValue>(
                                          valueListenable: _controller,
                                          builder: (context, value, child) =>
                                              value.isInitialized
                                                  ? LinearProgressIndicator(
                                                      value: _durationController
                                                          .value,
                                                      backgroundColor:
                                                          NartusColor.white
                                                              .withOpacity(0.3),
                                                      color: NartusColor.white,
                                                    )
                                                  : const SizedBox(),
                                        ),
                                      ),
                                    )),
                            ActivityFeedCard(
                                privacyIcon: null, // todo update in the future
                                semanticsPrivacyIcon: '',
                                avatarPath: widget.photoUrl,
                                displayName: widget.displayName,
                                dateTime: S.current.diaryDateFormatter(
                                  widget.dateTime,
                                  widget.dateTime,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    _animationController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _initVideoController() async {
    await _controller.initialize();

    if (_controller.value.isInitialized) {
      _durationController.duration = _controller.value.duration;
    }

    _controller.addListener(() {
      if (!_controller.value.isPlaying) {
        // stop playing
        _animationController.reverse();
        // reset duration
        _durationController.value = 0;
      } else {
        _animationController.forward();
        _durationController.forward(from: _currentVideoPosition());
      }
    });
  }

  void onPlayButtonTapped(bool isPlaying) {
    if (isPlaying) {
      _controller.pause();
      _animationController.reverse();
      _durationController.value = _currentVideoPosition();
    } else {
      _controller.play();
      _animationController.forward();
    }
  }

  double _currentVideoPosition() {
    try {
      return _controller.value.position.inMilliseconds /
          _controller.value.duration.inMilliseconds;
    } catch (e) {
      return 0;
    }
  }

  String _createDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}

class VideoPlayUI extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  final Animation<double> fadeAnimation;

  const VideoPlayUI(
      {required this.videoPlayerController,
      required this.fadeAnimation,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: videoPlayerController,
            builder: (context, value, child) => value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Center(
            child: ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: videoPlayerController,
              builder: (context, value, child) => Material(
                color: Colors.transparent,
                child: AnimatedBuilder(
                  animation: fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: fadeAnimation.value,
                      child: SvgPicture.asset(
                        value.isPlaying ? Assets.icon.pause : Assets.icon.play,
                        semanticsLabel:
                            value.isPlaying ? S.current.pause : S.current.play,
                        width: NartusDimens.radius56,
                        height: NartusDimens.radius56,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      );
}
