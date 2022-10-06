import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/widgets/marker.dart';
import 'dart:ui' as ui;

class IDHome extends StatefulWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  State<IDHome> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHome> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LocationBloc, LocationState>(
          builder: (BuildContext context, LocationState state) {
        GlobalKey iconKey = GlobalKey();

        if (state is LocationReadyState) {
          return Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(state.currentLocation.latitude,
                        state.currentLocation.longitude),
                    zoom: 15),
                markers: <Marker>{
                  Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(state.currentLocation.latitude,
                          state.currentLocation.longitude),
                      icon: state.icon)
                },
              ),
              SafeArea(
                  child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  margin: const EdgeInsets.only(top: Dimension.spacing16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.spacing16)),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimension.spacing16,
                        vertical: Dimension.spacing8),
                    child: Text(
                      state.dateDisplay,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ))
            ],
          );
        }

        if (state is LocationInitial) {
          context
              .read<LocationBloc>()
              .add(RequestCurrentLocationEvent(iconKey));
        }

        if (state is LocationPermissionDeniedState) {
          context.showDialogAdaptive(
              title: Text(S.of(context).locationPermissionDialogTitle),
              content: Text(S.of(context).locationPermissionDialogMessage),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      debugPrint('show dialog');
                      context
                          .read<LocationBloc>()
                          .add(ShowDialogRequestPermissionEvent());

                      Navigator.of(context).pop();
                    },
                    child: Text(
                        S.of(context).locationPermissionDialogAllowButton)),
                TextButton(
                    onPressed: () {
                      debugPrint('click continue button');
                      Navigator.of(context).pop();
                      context
                          .read<LocationBloc>()
                          .add(RequestDefaultLocationEvent());
                    },
                    child: Text(
                        S.of(context).locationPermissionDialogContinueButton)),
              ]);
        }

        if (state is LocationPermissionDeniedForeverState) {
          context.showDialogAdaptive(
              title: Text(S.of(context).locationPermissionDialogTitle),
              content: Text(S.of(context).locationPermissionDialogMessage),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      debugPrint('show dialog');
                      context.read<LocationBloc>().add(OpenAppSettingsEvent());

                      Navigator.of(context).pop();
                    },
                    child: Text(S
                        .of(context)
                        .locationPermissionDialogOpenSettingsButton)),
                TextButton(
                    onPressed: () {
                      debugPrint('click continue button');
                      Navigator.of(context).pop();
                      context
                          .read<LocationBloc>()
                          .add(RequestDefaultLocationEvent());
                    },
                    child: Text(
                        S.of(context).locationPermissionDialogContinueButton)),
              ]);
        }

        if (state is AwaitLocationPermissionFromAppSettingState) {
          WidgetsBinding.instance.addObserver(this);
        }

        return Scaffold(
          body: Center(
            child: MarkerIcon(
              globalKeyMyWidget: iconKey,
              height: 40,
            ),
          ),
        );
      });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.removeObserver(this);
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());
    }
  }
}
