import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';

import '../circle_menu_view.dart';
import '../test_screen.dart';

class IDHome extends StatefulWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  State<IDHome> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHome> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool isShowingMenu = false;

  @override
  Widget build(BuildContext context) {
    print('BUILD MAP');
    return Scaffold(
      body:  BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState state) {
          debugPrint('BUILDER');
          if (state is LocationReadyState) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  onCameraMoveStarted: () => _closeMenuIfOpening(),
                  onTap: (data) {
                    print('ON TAP : $data');
                    _closeMenuIfOpening();
                  },
                  onCameraIdle: () {
                    print('onCameraIdle');
                  },
                  onCameraMove: (_) => _closeMenuIfOpening(),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(state.currentLocation.latitude,
                          state.currentLocation.longitude),
                      zoom: 15),
                  markers: <Marker>{
                    Marker(
                      onTap: () {
                        setState(() {
                          isShowingMenu = !isShowingMenu;
                        });
                      },
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(state.currentLocation.latitude,
                          state.currentLocation.longitude),
                    )
                  },
                ),
                CircleMenuView(isShowingMenu: isShowingMenu,),
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
    if (isShowingMenu) {
      setState(() {
        isShowingMenu = false;
      });
      // WidgetsBinding.instance.addPostFrameCallback((_) =>
      //     setState(() {
      //       isShowingMenu = false;
      //     }));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.removeObserver(this);
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());
    }
  }
}

class CircularButton extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton({
    required this.color, required this.width, required this.height,
    required this.icon, required this.onClick});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color,shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: () => onClick.call()),
    );
  }
}