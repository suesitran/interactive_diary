import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:interactive_diary/constants/resources.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';

import 'package:interactive_diary/features/circle_menu_view.dart';

class IDHome extends StatefulWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  State<IDHome> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHome>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late GoogleMapController mapCtrl;
  int markerXCoordinate = 0;
  int markerYCoordinate = 0;
  final double menuIconSize = 40;
  late IDCircleMenuController menuCtrl;

  @override
  void initState() {
    menuCtrl = IDCircleMenuController();
    super.initState();
  }

  @override
  void dispose() {
    mapCtrl.dispose();
    menuCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState state) {
          debugPrint('BUILDER');
          if (state is LocationReadyState) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) =>
                      mapCtrl = controller,
                  onCameraMoveStarted: () => _closeMenuIfOpening(),
                  onTap: (_) => _closeMenuIfOpening(),
                  // onCameraMove: (_) => _closeMenuIfOpening(),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(state.currentLocation.latitude,
                          state.currentLocation.longitude),
                      zoom: 15),
                  markers: <Marker>{
                    Marker(
                      onTap: () async {
                        final LatLng currentMarkerLatLng = LatLng(
                            state.currentLocation.latitude,
                            state.currentLocation.longitude);

                        /// Bring current marker to center of the screen by moving camera
                        await mapCtrl.moveCamera(CameraUpdate.newLatLng(LatLng(
                            currentMarkerLatLng.latitude,
                            currentMarkerLatLng.longitude)));

                        /// Convert current marker LatLong to Screen X, Y
                        final ScreenCoordinate coordinate =
                            await mapCtrl.getScreenCoordinate(LatLng(
                                currentMarkerLatLng.latitude,
                                currentMarkerLatLng.longitude));

                        setState(() {
                          markerXCoordinate = coordinate.x;
                          markerYCoordinate = coordinate.y;
                        });

                        /// Wait until finish setting Circle menu point to marker coordinate
                        /// then show the menu
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          menuCtrl.changePresentingStatus();
                        });
                      },
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(state.currentLocation.latitude,
                          state.currentLocation.longitude),
                    )
                  },
                ),
                Positioned(
                    left: (markerXCoordinate - (menuIconSize / 2)).toDouble(),
                    top: (markerYCoordinate - (menuIconSize / 2)).toDouble(),
                    child: IDCircleMenuView(
                      controller: menuCtrl,
                    )),
                SafeArea(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    margin: const EdgeInsets.only(top: Dimension.spacing16),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimension.spacing16)),
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
            context.read<LocationBloc>().add(RequestCurrentLocationEvent());
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
                      child: Text(S
                          .of(context)
                          .locationPermissionDialogContinueButton)),
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
                        context
                            .read<LocationBloc>()
                            .add(OpenAppSettingsEvent());

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
                      child: Text(S
                          .of(context)
                          .locationPermissionDialogContinueButton)),
                ]);
          }

          if (state is AwaitLocationPermissionFromAppSettingState) {
            WidgetsBinding.instance.addObserver(this);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _closeMenuIfOpening() {
    /// OLD WORKED VERSION
    // if (isShowingMenu) {
    //   setState(() {
    //     isShowingMenu = false;
    //   });
    // }

    menuCtrl.closeMenu();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.removeObserver(this);
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());
    }
  }
}
