import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';

import 'package:interactive_diary/gen/assets.gen.dart';

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
  Size menuIconSize = const Size(0, 0);
  late IDCircularMenuController menuCtrl;
  final GlobalKey menuIconWidgetKey = GlobalKey();

  Future<List<Marker>> generateListMarkers(
      double latitude, double longitude) async {
    List<Marker> markers = <Marker>[];
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
            await mapCtrl.moveCamera(
                CameraUpdate.newLatLng(LatLng(latitude, longitude)));

            /// Convert current marker LatLong to Screen X, Y
            final ScreenCoordinate coordinate =
                await mapCtrl.getScreenCoordinate(LatLng(latitude, longitude));
            markerXCoordinate = coordinate.x;
            markerYCoordinate = coordinate.y;
          }

          setState(() {
            isAnimation = !isAnimation;
          });

          /// Wait until finish moving Circle menu base point to marker coordination
          /// then pop up the menu
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final RenderBox renderBox = menuIconWidgetKey.currentContext
                ?.findRenderObject() as RenderBox;
            setState(() {
              menuIconSize = Size(renderBox.size.width, renderBox.size.height);
            });

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
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
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
                              onMapCreated: (GoogleMapController controller) =>
                                  mapCtrl = controller,
                              onCameraMoveStarted: () => _closeMenuIfOpening(),
                              onTap: (_) => _closeMenuIfOpening(),
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(state.currentLocation.latitude,
                                      state.currentLocation.longitude),
                                  zoom: 15),
                              markers: Set<Marker>.of(
                                  snapshot.data as Iterable<Marker>));
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  Positioned(
                      left: (markerXCoordinate - (menuIconSize.width / 2))
                          .toDouble(),
                      top: (markerYCoordinate - (menuIconSize.height / 2))
                          .toDouble(),
                      child: IDCircularMenuView(
                        items: <IDCircularMenuItemData>[
                          IDCircularMenuItemData(
                              item: IDCircleMenuButton(
                                  key: menuIconWidgetKey,
                                  iconPath: Assets.images.idPencilIcon),
                              degree: 210.0,
                              onPressed: () {}),
                          IDCircularMenuItemData(
                              item: IDCircleMenuButton(
                                  iconPath: Assets.images.idCameraIcon),
                              degree: 250.0,
                              onPressed: () {}),
                          IDCircularMenuItemData(
                              item: IDCircleMenuButton(
                                  iconPath: Assets.images.idMicroIcon),
                              degree: 290.0,
                              onPressed: () {}),
                          IDCircularMenuItemData(
                              item: IDCircleMenuButton(
                                  iconPath: Assets.images.idSmileIcon),
                              degree: 330.0,
                              onPressed: () {}),
                        ],
                        controller: menuCtrl,
                      )),
                  SafeArea(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: DateLabelView(
                      dateLabel: state.dateDisplay,
                      profileSemanticLabel: S.of(context).anonymous_profile,
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
      menuCtrl.close();
    }
  }
}

class IDCircleMenuButton extends StatelessWidget {
  final String iconPath;

  /// This is for the case we don't want to show this button size when no popup
  final bool? isShowing;
  const IDCircleMenuButton(
      {required this.iconPath, this.isShowing = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isShowing! ? null : 0,
      height: isShowing! ? null : 0,
      decoration: BoxDecoration(
          color: NartusColor.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.24),
      child: SvgPicture.asset(iconPath),
    );
  }
}
