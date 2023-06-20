import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/camera_control_layer.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/camera_setup_cubit.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/media_permission_cubit.dart';
import 'package:nartus_storage/nartus_storage.dart';

class CameraScreen extends StatelessWidget {
  final LatLng latLng;
  const CameraScreen({required this.latLng, Key? key}) : super(key: key);

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
              if (state is CameraMediaReady) {
                context.gotoPreviewMediaScreen(latLng, state.path, state.type);
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
                value ? controller.buildPreview() : const SizedBox.expand(),
          ),
          CameraControlsLayer(
            onGalleryTapped: () {
              context.read<MediaPermissionCubit>().checkMediaPermission();
            },
            onShutterTapped: () =>
                context.read<CameraSetupCubit>().takePhoto(controller),
            onShutterLongPressStart: () {
              HapticFeedback.mediumImpact();
              context.read<CameraSetupCubit>().recordVideo(controller);
            },
            onShutterLongPressEnd: () {
              context.read<CameraSetupCubit>().stopRecordVideo(controller);
            },
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
