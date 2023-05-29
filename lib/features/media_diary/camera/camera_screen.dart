import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/camera_setup_cubit.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/media_permission_cubit.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MediaPermissionCubit>(
          create: (context) => MediaPermissionCubit(),
        ),
        BlocProvider<CameraSetupCubit>(
          create: (_) => CameraSetupCubit(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<MediaPermissionCubit, MediaPermissionState>(
            listener: (context, state) {
              if (state is MediaPermissionGranted) {
                context.goToPhotoAlbum();
              }

              if (state is RequestMediaPermission) {
                context.read<MediaPermissionCubit>().requestMediaPermission();
              }

              if (state is MediaPermissionDenied) {
                // do nothing
              }

              if (state is MediaPermissionDeniedForever) {
                // show popup to let user allow permission in settings
              }
            },
          ),
          BlocListener<CameraSetupCubit, CameraSetupState>(
            listener: (context, state) {
              if (state is CameraPictureReady) {
                context.gotoPreviewMediaScreen(state.path);
              }
            },
          )
        ],
        child: const CameraPreviewBody(),
      ),
    );
  }
}

class CameraPreviewBody extends StatefulWidget {
  const CameraPreviewBody({Key? key}) : super(key: key);

  @override
  State<CameraPreviewBody> createState() => _CameraPreviewBodyState();
}

class _CameraPreviewBodyState extends State<CameraPreviewBody> {
  late final CameraController controller;
  late List<CameraDescription> cameras;

  final ValueNotifier<bool> _cameraReady = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _initCamera();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _cameraReady,
            builder: (context, value, child) =>
                value ? controller.buildPreview() : const SizedBox(),
          ),
          Positioned(
              top: 0,
              left: NartusDimens.padding16,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: NartusDimens.padding16),
                  child: CircleButton(
                    size: NartusDimens.padding40,
                    iconPath: Assets.images.closeIcon,
                    semantic: S.current.close,
                    onPressed: () => context.pop(),
                  ),
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: NartusDimens.padding16),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Builder(builder: (context) {
                        return CircleButton(
                          size: NartusDimens.padding40,
                          iconPath: Assets.images.galleryIcon,
                          semantic: S.current.openDeviceGallery,
                          onPressed: () {
                            context
                                .read<MediaPermissionCubit>()
                                .checkMediaPermission();
                          },
                        );
                      }),
                      Semantics(
                        button: true,
                        enabled: true,
                        excludeSemantics: true,
                        explicitChildNodes: false,
                        label: S.current.captureMediaButton,
                        child: Container(
                          width: NartusDimens.padding40 +
                              NartusDimens.padding32 +
                              NartusDimens.padding4,
                          height: NartusDimens.padding40 +
                              NartusDimens.padding32 +
                              NartusDimens.padding4,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: NartusColor.white,
                                  width: NartusDimens.padding4),
                              color: Colors.transparent),
                          padding: const EdgeInsets.all(NartusDimens.padding2),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: NartusColor.white, width: 4),
                                color: Colors.white),
                            child: NartusButton.text(
                              label: '',
                              onPressed: () {
                                context
                                    .read<CameraSetupCubit>()
                                    .takePhoto(controller);
                              },
                            ),
                          ),
                        ),
                      ),
                      CircleButton(
                        size: NartusDimens.padding40,
                        iconPath: Assets.images.flipIcon,
                        semantic: S.current.flipCamera,
                        onPressed: () {},
                      )
                    ],
                  ),
                  const Gap.v16(),
                  const Gap.v20(),
                  Text(
                    S.current.holdToRecord,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: NartusColor.white,
                        ),
                  )
                ]),
              ),
            ),
          )
        ],
      ));

  Future<void> _initCamera() async {
    cameras = await availableCameras();

    if (cameras.isEmpty) {
      // TODO handle when device has no camera
      return;
    }

    // start with back camera
    controller =
        CameraController(_findBackCamera(cameras), ResolutionPreset.max);
    try {
      await controller.initialize();
    } on CameraException catch (_) {
      // TODO handle when camera fails to initialise
    }
    _cameraReady.value = controller.value.isInitialized;
  }

  // CameraDescription _findFrontCamera(List<CameraDescription> cameras) => cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front, orElse: () => cameras.first,);
  CameraDescription _findBackCamera(List<CameraDescription> cameras) =>
      cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
}
