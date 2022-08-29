import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';

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
            context.showDialogAdaptive(
                title: const Text('Location Permission not granted'),
                content: const Text(
                    'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                        context
                            .read<LocationBloc>()
                            .add(RequestPermissionLocationEvent());
                      },
                      child: Text('Allow')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(false);
                        context
                            .read<LocationBloc>()
                            .add(DefaultLocationServiceEvent());
                      },
                      child: Text('Continue')),
                ]);
          }

          if (state is LocationInitial) {
            print('RequestCurrentLocationEvent');
            context.read<LocationBloc>().add(RequestCurrentLocationEvent());
          }

          if (state is LocationPermissionDeniedState) {
            context.showDialogAdaptive(
                title: const Text('Location Permission not granted'),
                content: const Text(
                    'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                        context
                            .read<LocationBloc>()
                            .add(DefaultLocationServiceEvent());
                      },
                      child: const Text('Allow')),
                ]);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}
