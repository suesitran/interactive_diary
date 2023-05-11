import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/features/camera/widgets/buttons.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isRecordingVideo = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _isRecordingVideo.dispose();
        return Future.value(true);
      },
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              alignment: Alignment.center,
               decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg?cs=srgb&dl=pexels-tyler-nix-2396220.jpg&fm=jpg',
                  )
                )
              ),
              
            ),
            Positioned(
                top: NartusDimens.padding40 + NartusDimens.padding4,
                left: NartusDimens.padding16,
                child: CircleButton(
                  size: NartusDimens.padding40,
                  iconPath: Assets.images.closeIcon,
                  semantic: S.current.close,
                  onPressed: () => context.pop(),
                )),
            if (_isRecordingVideo.value)
              ...[]
            else ...[
              Positioned(
                left: 0, right: 0,
                // bottom: NartusDimens.padding4 + NartusDimens.padding20,
                bottom: MediaQuery.of(context).viewPadding.bottom,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: _isRecordingVideo,
                          builder: (_, isRecording, __) {
                            if (!isRecording) {
                              return CircleButton(
                                size: NartusDimens.padding40,
                                iconPath: Assets.images.galleryIcon,
                                semantic: S.current.openDeviceGallery,
                                onPressed: () => context.goToHome(),
                              );
                            }
                            return const SizedBox();
                          }),
                      CaptureMediaButton(
                        onCapturedImage: () => context.gotoPreviewMediaScreen(),
                        onEndRecordVideo: () {
                          _isRecordingVideo.value = false;
                          context.gotoPreviewMediaScreen();
                        },
                        onStartRecordVideo: () =>
                            _isRecordingVideo.value = true,
                      ),
                      ValueListenableBuilder<bool>(
                          valueListenable: _isRecordingVideo,
                          builder: (_, isRecording, __) {
                            if (!isRecording) {
                              return CircleButton(
                                size: NartusDimens.padding40,
                                iconPath: Assets.images.flipIcon,
                                semantic: S.current.flipCamera,
                                onPressed: () => context.goToHome(),
                              );
                            }
                            return const SizedBox();
                          }),
                    ],
                  ),
                  const Gap.v16(),
                  const Gap.v20(),
                  ValueListenableBuilder<bool>(
                      valueListenable: _isRecordingVideo,
                      builder: (_, isRecording, __) {
                        return Text(
                          !isRecording ? S.current.holdToRecord : '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: NartusColor.white,
                                  ),
                        );
                      }),
                ]),
              )
            ]
          ],
        ),
      )),
    );
  }
}