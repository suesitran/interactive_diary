import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:interactive_diary/route/map_route.dart';
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
        body: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (BuildContext context, ConnectivityState state) {
            WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
              context
                  .read<ConnectivityBloc>()
                  .add(ChangeConnectConnectivityEvent());
            });
            if (state is ChangeConnectedState) {
              debugPrint('change to connect');
            }
            if (state is ChangeDisonnectedState) {
              debugPrint('change to Disconnect');
              context.push('/noConnection');
            }
            if (state is ConnectedState) {
              debugPrint('connected');
            }
            if (state is DisconnectedState) {
              debugPrint('disconnected');
              context.push('/noConnection');
            }
          },
          child: BlocBuilder<LocationBloc, LocationState>(
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
                context
                    .read<ConnectivityBloc>()
                    .add(ConnectedConnectivityEvent());
              }

              if (state is LocationPermissionDeniedState) {
                context.showDialogAdaptive(
                    title: Text(S.of(context).locationPermissionDialogTitle),
                    content:
                        Text(S.of(context).locationPermissionDialogMessage),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            debugPrint('show dialog');
                            context
                                .read<LocationBloc>()
                                .add(ShowDialogRequestPermissionEvent());

                            Navigator.of(context).pop();
                          },
                          child: Text(S
                              .of(context)
                              .locationPermissionDialogAllowButton)),
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
                    content:
                        Text(S.of(context).locationPermissionDialogMessage),
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
