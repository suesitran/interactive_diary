import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';
import 'package:interactive_diary/features/home/content_panel/contents_bottom_panel_view.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/home/bloc/location_bloc.dart';
import 'package:interactive_diary/generated/l10n.dart';

class IDHome extends StatelessWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<LocationBloc>(
        create: (context) => LocationBloc(),
        child: const IDHomeBody(),
      );
}

class IDHomeBody extends StatefulWidget {
  const IDHomeBody({Key? key}) : super(key: key);

  @override
  State<IDHomeBody> createState() => _IDHomeState();
}

class _IDHomeState extends State<IDHomeBody> with WidgetsBindingObserver {
  final ContentsBottomPanelController _contentBottomPanelController =
      ContentsBottomPanelController();

  @override
  Widget build(BuildContext context) => Scaffold(
          body: MultiBlocListener(
        // ignore: always_specify_types
        listeners: [
          BlocListener<LocationBloc, LocationState>(
            listener: (BuildContext context, LocationState state) {
              if (state is LocationServiceDisableState) {
                context.showIDBottomSheet(
                    iconPath: Assets.images.idLocationImg,
                    title: S.current.locationPermissionDialogTitle,
                    content: S.current.locationPermissionDialogMessage,
                    primaryButtonText:
                        S.current.locationPermissionDialogOpenSettingsButton,
                    onPrimaryButtonSelected: () {
                      // can't dismiss popup dialog here because ios16 does not allow
                      // to directly go to Location settings
                      context.read<LocationBloc>().openLocationServiceSetting();
                    },
                    textButtonText:
                        S.current.locationPermissionDialogContinueButton,
                    onTextButtonSelected: () {
                      Navigator.of(context).pop();
                      context.read<LocationBloc>().requestDefaultLocation();
                    },
                    isDismissible: false);
              }

              if (state is LocationPermissionDeniedForeverState ||
                  state is LocationPermissionDeniedState) {
                final String title =
                    state is LocationPermissionDeniedForeverState
                        ? S.current.locationPermissionDialogTitle
                        : S.current.locationPermissionDeniedBottomSheetTitle;

                final String content = state
                        is LocationPermissionDeniedForeverState
                    ? S.current.locationPermissionDialogMessage
                    : S.current.locationPermissionDeniedBottomSheetDescription;

                final String primaryButtonText =
                    state is LocationPermissionDeniedForeverState
                        ? S.current.locationPermissionDialogOpenSettingsButton
                        : S.current.locationPermissionDialogAllowButton;

                final String textButtonText =
                    S.current.locationPermissionDialogContinueButton;

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
                            .showDialogRequestPermissionEvent();
                      } else if (state
                          is LocationPermissionDeniedForeverState) {
                        context.read<LocationBloc>().openAppSettings();
                      }
                      Navigator.of(context).pop();
                    },
                    onTextButtonSelected: () {
                      context.read<LocationBloc>().requestDefaultLocation();
                      Navigator.of(context).pop();
                    });
              }
            },
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is DisconnectedState) {
                context.showDisconnectedOverlay();
              }

              if (state is ConnectedState) {
                context.hideDisconnectedOverlay();
              }
            },
          )
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
                              profileSemanticLabel: S.current.anonymous_profile,
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
              context.read<LocationBloc>().requestCurrentLocation();
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
      context.read<LocationBloc>().onReturnFromSettings();

      if (blocState is AwaitLocationServiceSettingState &&
          Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void handleMenuOpen() {
    _contentBottomPanelController.show();
  }

  void handleMenuClose() {
    _contentBottomPanelController.dismiss();
  }
}
