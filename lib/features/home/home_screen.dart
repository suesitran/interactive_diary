import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';

import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IDHome extends Screen {
  const IDHome({
    Key? key,
  }) : super(key: key);

  primaryButtonPress(BuildContext context) {}

  secondaryButtonPress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(false);
  }

  @override
  Widget body(BuildContext context) => BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState state) {
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
                    )
                  },
                ),
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

          if (state is LocationPermissionNotGrantedState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              var value = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => DialogRequest(
                      title: 'Location Permission not granted',
                      content:
                          'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog',
                      primaryButtonTitle: 'Allow',
                      secondaryButtonTitle: 'Continue',
                      primaryButtonPress: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      secondaryButtonPress: () {
                        Navigator.of(context, rootNavigator: true).pop(false);
                      }));
              if (value!) {
                context
                    .read<LocationBloc>()
                    .add(RequestPermissionLocationEvent());
              } else {
                context.read<LocationBloc>().add(DefaultLocationServiceEvent());
              }
            });
          }

          if (state is LocationInitial) {
            print('RequestCurrentLocationEvent');
            context.read<LocationBloc>().add(RequestCurrentLocationEvent());
          }

          if (state is LocationPermissionDeniedState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              var value = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => DialogRequest(
                      title: 'Why does app need location Permission',
                      content: 'Explain why does app need location Permission',
                      primaryButtonTitle: 'Allow',
                      secondaryButtonTitle: '',
                      primaryButtonPress: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      secondaryButtonPress: () {}));
              if (value!) {
                context.read<LocationBloc>().add(DefaultLocationServiceEvent());
              }
              // bool value = await showDialog<bool>(
              //       context: context,
              //       builder: (BuildContext context) => DialogRequest(
              //         typeDialog: 1,
              //       ),
              //     ) ??
              //     false;
              // if (value) {
              //   // ignore: use_build_context_synchronously
              //   context.read<LocationBloc>().add(DefaultLocationServiceEvent());
              // }
            });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}
