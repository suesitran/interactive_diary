import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/googe_map.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';

class IDHome extends StatefulWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  State<IDHome> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHome> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (BuildContext context, LocationState state) {
            if (state is LocationReadyState) {
              return Stack(
                children: <Widget>[
                  GoogleMapView(
                    currentLocation: state.currentLocation,
                  ),
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
}
