import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/resources.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_color.dart';

class IDHome extends StatefulWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  State<IDHome> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHome> with WidgetsBindingObserver {
  bool isAnimation = false;
  late Future<List<Marker>> futureListMarker;
  late GoogleMapController mapCtrl;
  int markerXCoordinate = 0;
  int markerYCoordinate = 0;
  final double menuIconSize = 40;
  late IDCircularMenuController menuCtrl;

  Future<List<Marker>> generateListMarkers(
      double latitude, double longitude) async {
    List<Marker> markers = [];
    final BitmapDescriptor icon = isAnimation == true
        ? await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(24, 24)),
            'assets/images/marker_ontap.png')
        : await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(24, 24)),
            'assets/images/marker_nonetap.png');

    final Marker marker = Marker(
        markerId: MarkerId(latitude.toString()),
        position: LatLng(latitude, longitude),
        icon: icon,
        onTap: () async {
          if (!isAnimation) {
            /// Bring current marker to center of the screen by moving camera
            await mapCtrl.moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));

            /// Convert current marker LatLong to Screen X, Y
            final ScreenCoordinate coordinate = await mapCtrl.getScreenCoordinate(
                LatLng(latitude, longitude));
            markerXCoordinate = coordinate.x;
            markerYCoordinate = coordinate.y;
          }

          await Future.delayed(Duration(seconds: 1));
          setState(() {
            isAnimation = !isAnimation;
          });

          /// Wait until finish setting Circle menu point to marker coordinate
          /// then show the menu
          WidgetsBinding.instance.addPostFrameCallback((_) {
            menuCtrl.changePresentingStatus();
          });
        });
    markers.add(marker);
    return markers;
  }

  @override
  void initState() {
    menuCtrl = IDCircularMenuController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState state) {
          if (state is LocationReadyState) {
            futureListMarker = generateListMarkers(
                state.currentLocation.latitude,
                state.currentLocation.longitude);

            return Stack(
              children: <Widget>[
                FutureBuilder<List<Marker>>(
                    future: futureListMarker,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Marker>> snapshot) {
                      if (snapshot.hasData) {
                        return GoogleMap(
                            onMapCreated: (GoogleMapController controller) => mapCtrl = controller,
                            onCameraMoveStarted: () => _closeMenuIfOpening(),
                            onTap: (_) => _closeMenuIfOpening(),
                            initialCameraPosition: CameraPosition(
                                target: LatLng(state.currentLocation.latitude,
                                    state.currentLocation.longitude),
                                zoom: 15),
                            markers: Set<Marker>.of(
                                snapshot.data as Iterable<Marker>),

                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                Positioned(
                  left: (markerXCoordinate - (menuIconSize / 2)).toDouble(),
                  top: (markerYCoordinate - (menuIconSize / 2)).toDouble(),
                  child: CircleMenuView(controller: menuCtrl),
                ),
                // SafeArea(
                //     child: Align(
                //   alignment: Alignment.topCenter,
                //   child: Card(
                //     margin: const EdgeInsets.only(top: Dimension.spacing16),
                //     shape: RoundedRectangleBorder(
                //         borderRadius:
                //             BorderRadius.circular(Dimension.spacing16)),
                //     elevation: 4.0,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: Dimension.spacing16,
                //           vertical: Dimension.spacing8),
                //       child: Text(
                //         state.dateDisplay,
                //         style: const TextStyle(fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //   ),
                // ))
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
      );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.removeObserver(this);
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());
    }
  }

  @override
  void dispose() {
    mapCtrl.dispose();
    menuCtrl.dispose();
    super.dispose();
  }

  void _closeMenuIfOpening() {
    if (menuCtrl.isShowing) {
      setState(() {
        isAnimation = false;
      });
      menuCtrl.closeMenu();
    }
  }
}

class CircleMenuView extends StatefulWidget {
  final IDCircularMenuController controller;
  const CircleMenuView({required this.controller, Key? key}) : super(key: key);

  @override
  _CircleMenuViewState createState() => _CircleMenuViewState();
}

class _CircleMenuViewState extends State<CircleMenuView> {
  bool isShowing = false;
  final Color menuItemColor = NartusColor.primary;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        isShowing = !isShowing;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IDCircularMenuView(
      items: <IDCircularMenuItemData>[
        IDCircularMenuItemData(
            IDCircleMenuButton(
              backgroundColor: menuItemColor,
              iconPath: IDIcons.pencil,
              isShowing: isShowing,
            ),
            210.0),
        IDCircularMenuItemData(
            IDCircleMenuButton(
              backgroundColor: menuItemColor,
              iconPath: IDIcons.camera,
              isShowing: isShowing,
            ),
            250.0),
        IDCircularMenuItemData(
            IDCircleMenuButton(
              backgroundColor: menuItemColor,
              iconPath: IDIcons.micro,
              isShowing: isShowing,
            ),
            290.0),
        IDCircularMenuItemData(
            IDCircleMenuButton(
              backgroundColor: menuItemColor,
              iconPath: IDIcons.smile,
              isShowing: isShowing,
            ),
            330.0),
      ],
      controller: widget.controller,
    );
  }
}

class IDCircleMenuButton extends StatelessWidget {
  final Color backgroundColor;
  final String iconPath;
  final bool isShowing;
  const IDCircleMenuButton(
      {required this.backgroundColor, required this.iconPath, required this.isShowing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isShowing ? null : 0, height: isShowing ? null : 0,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.24),
      child: SvgPicture.asset(iconPath),
    );
  }
}