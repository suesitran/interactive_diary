import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/features/home/content_panel/contents_bottom_panel_view.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
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
  final ContentsBottomPanelController _contentBottomPanelController =
      ContentsBottomPanelController();

  @override
  Widget build(BuildContext context) => Scaffold(
          body: MultiBlocListener(
        // ignore: always_specify_types
        listeners: [
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (BuildContext context, ConnectivityState state) {
              WidgetsBinding.instance
                  .addPostFrameCallback((Duration timeStamp) {
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
          ),
          BlocListener<LocationBloc, LocationState>(
            listener: (BuildContext context, LocationState state) {
              if (state is LocationServiceDisableState) {
                context.showIDBottomSheet(
                    iconPath: Assets.images.idLocationImg,
                    title: S.of(context).locationPermissionDialogTitle,
                    content: S.of(context).locationPermissionDialogMessage,
                    primaryButtonText: S
                        .of(context)
                        .locationPermissionDialogOpenSettingsButton,
                    onPrimaryButtonSelected: () {
                      // can't dismiss popup dialog here because ios16 does not allow
                      // to directly go to Location settings
                      context
                          .read<LocationBloc>()
                          .add(OpenLocationServiceEvent());
                    },
                    textButtonText:
                        S.of(context).locationPermissionDialogContinueButton,
                    onTextButtonSelected: () {
                      Navigator.of(context).pop();
                      context
                          .read<LocationBloc>()
                          .add(RequestDefaultLocationEvent());
                    },
                    isDismissible: false);
              }

              if (state is LocationPermissionDeniedForeverState ||
                  state is LocationPermissionDeniedState) {
                final String title = state
                        is LocationPermissionDeniedForeverState
                    ? S.of(context).locationPermissionDialogTitle
                    : S.of(context).locationPermissionDeniedBottomSheetTitle;

                final String content =
                    state is LocationPermissionDeniedForeverState
                        ? S.of(context).locationPermissionDialogMessage
                        : S
                            .of(context)
                            .locationPermissionDeniedBottomSheetDescription;

                final String primaryButtonText = state
                        is LocationPermissionDeniedForeverState
                    ? S.of(context).locationPermissionDialogOpenSettingsButton
                    : S.of(context).locationPermissionDialogAllowButton;

                final String textButtonText =
                    S.of(context).locationPermissionDialogContinueButton;

                context.showIDBottomSheet(
                    iconPath: Assets.images.idLocationImg,
                    title: title,
                    isDismissible: false,
                    content: content,
                    primaryButtonText: primaryButtonText,
                    textButtonText: textButtonText,
                    onPrimaryButtonSelected: () {
                      if (state is LocationPermissionDeniedState) {
                        context
                            .read<LocationBloc>()
                            .add(ShowDialogRequestPermissionEvent());
                      } else if (state
                          is LocationPermissionDeniedForeverState) {
                        context
                            .read<LocationBloc>()
                            .add(OpenAppSettingsEvent());
                      }
                      Navigator.of(context).pop();
                    },
                    onTextButtonSelected: () {
                      context
                          .read<LocationBloc>()
                          .add(RequestDefaultLocationEvent());
                      Navigator.of(context).pop();
                    });
              }
            },
          ),
        ],
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (BuildContext context, LocationState state) {
            // remove previous observer, if any
            WidgetsBinding.instance.removeObserver(this);
            if (state is LocationReadyState) {
              return Stack(
                children: <Widget>[
                  GoogleMapView(
                    currentLocation: state.currentLocation,
                    onMenuOpened: handleMenuOpen,
                    onMenuClosed: handleMenuClose,
                  ),
                  Column(
                    children: <Widget>[
                      SafeArea(
                          bottom: false,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: DateLabelView(
                              dateLabel: state.dateDisplay,
                              profileSemanticLabel:
                                  S.of(context).anonymous_profile,
                            ),
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ContentsBottomPanelView(
                              controller: _contentBottomPanelController),
                        ),
                      )
                    ],
                  )
                ],
              );
            }

            if (state is LocationInitial) {
              context.read<LocationBloc>().add(RequestCurrentLocationEvent());
              context
                  .read<ConnectivityBloc>()
                  .add(ConnectedConnectivityEvent());
            }

            if (state is AwaitLocationPermissionFromAppSettingState ||
                state is AwaitLocationServiceSettingState) {
              WidgetsBinding.instance.addObserver(this);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ));

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final LocationState blocState = context.read<LocationBloc>().state;
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());

      if (blocState is AwaitLocationServiceSettingState &&
          Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  void handleMenuOpen() {
    _contentBottomPanelController.show();
  }

  void handleMenuClose() {
    _contentBottomPanelController.dismiss();
  }
}
