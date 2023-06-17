import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/features/media_diary/preview/bloc/preview_interaction_cubit.dart';
import 'package:interactive_diary/features/media_diary/preview/bloc/save_media_diary_cubit.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatelessWidget {
  final LatLng latLng;
  final String path;
  final MediaType type;
  const PreviewScreen(this.latLng, this.path, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PreviewInteractionCubit>(
          create: (context) => PreviewInteractionCubit(),
        ),
        BlocProvider<SaveMediaDiaryCubit>(
          create: (context) =>
              SaveMediaDiaryCubit(latLng: latLng, path: path, type: type),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PreviewInteractionCubit, PreviewInteractionState>(
              listener: (context, state) {
            if (state is OnFileDeleted) {
              context.pop();
            }
          }),
          BlocListener<SaveMediaDiaryCubit, SaveMediaDiaryState>(
            listener: (context, state) {
              if (state is SaveMediaDiaryComplete) {
                context.popToHome();
              }
            },
          )
        ],
        child: Scaffold(
          backgroundColor: NartusColor.white,
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(NartusDimens.radius24),
                            bottomRight:
                                Radius.circular(NartusDimens.radius24)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          color: NartusColor.onSecondaryContainer,
                          width: MediaQuery.of(context).size.width,
                          child: type == MediaType.picture
                              ? Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                )
                              : VideoPreview(path),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: NartusDimens.padding16,
                              left: NartusDimens.padding16),
                          child: Builder(builder: (context) {
                            return CircleButton(
                              size: NartusDimens.padding40,
                              iconPath: Assets.images.closeIcon,
                              semantic: S.current.close,
                              onPressed: () => context
                                  .read<PreviewInteractionCubit>()
                                  .onCancelPreview(path),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(NartusDimens.padding24),
                    child: Builder(builder: (context) {
                      return NartusButton.primary(
                        label: S.current.save,
                        onPressed: () {
                          context.read<SaveMediaDiaryCubit>().save();
                        },
                      );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPreview extends StatefulWidget {
  final String path;
  const VideoPreview(this.path, {Key? key}) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late final VideoPlayerController _controller =
      VideoPlayerController.file(File(widget.path));

  @override
  void initState() {
    super.initState();

    _initVideoController();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: _controller,
        builder: (context, value, child) => value.isInitialized
            ? VideoPlayer(_controller)
            : const SizedBox.expand(),
      );

  void _initVideoController() async {
    await _controller.initialize();

    // TODO may need to disable auto play in video preview
    _controller.play();
  }
}
