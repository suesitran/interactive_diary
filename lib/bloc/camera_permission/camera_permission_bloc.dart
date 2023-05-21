import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_media/nartus_media.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';

part 'camera_permission_event.dart';
part 'camera_permission_state.dart';

class CameraPermissionBloc extends Bloc<CameraPermissionEvent, CameraPermissionState> {
  final NartusMediaService mediaService = ServiceLocator.instance.get<NartusMediaService>();

  CameraPermissionBloc() : super(CameraPermissionInitial()) {
    on<RequestOpenCameraScreenEvent>(_validateCameraPermission);

    on<RequestCameraPermissionEvent>(_requestCameraPermission);
  }

  void _validateCameraPermission(CameraPermissionEvent event, Emitter<CameraPermissionState> emit) async {
    emit(CameraPermissionValidationStart());
    final MediaPermission permission = await mediaService.checkCameraPermission();

    switch(permission) {
      case MediaPermission.granted:
      case MediaPermission.limited:
        if (!isClosed) {
          emit(GoToCameraScreen());
        }
        break;
      case MediaPermission.deniedForever:
        if (!isClosed) {
          emit(PermissionDeniedForever());
        }
        break;
      default:
        if (!isClosed) {
          emit(RequestCameraPermission());
        }
    }
  }

  void _requestCameraPermission(CameraPermissionEvent event, Emitter<CameraPermissionState> emit) async {
    emit(CameraPermissionRequestStart());
    final MediaPermission permission = await mediaService.requestCameraPermission();

    switch(permission) {
      case MediaPermission.granted:
      case MediaPermission.limited:
        if (!isClosed) {
          emit(GoToCameraScreen());
        }
        break;
      case MediaPermission.deniedForever:
        if (!isClosed) {
          emit(PermissionDeniedForever());
        }
        break;
      default:
        // user denied  permission, do nothing.
    }
  }
}
