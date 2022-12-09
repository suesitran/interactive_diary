import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
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
        body: BlocConsumer<LocationBloc, LocationState>(
          listener: (BuildContext context, LocationState state) {
            if (state is LocationServiceDisableState) {
              context.showIDBottomSheet(
                  title: S.of(context).locationPermissionDialogTitle,
                  content: S.of(context).locationPermissionDialogMessage,
                  primaryButtonText:
                      S.of(context).locationPermissionDialogOpenSettingsButton,
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
            if (state is LocationPermissionDeniedForeverState || state is LocationPermissionDeniedState) {
              final String title = state is LocationPermissionDeniedForeverState
                  ? S.of(context).locationPermissionDialogTitle
                  : S.of(context).locationPermissionDeniedBottomSheetTitle;

              final String content = state is LocationPermissionDeniedForeverState
                  ? S.of(context).locationPermissionDialogMessage
                  : S.of(context).locationPermissionDeniedBottomSheetDescription;

              final String primaryButtonText = state is LocationPermissionDeniedForeverState
                  ? S.of(context).locationPermissionDialogOpenSettingsButton
                  : S.of(context).locationPermissionDialogAllowButton;

              final String textButtonText = S.of(context).locationPermissionDialogContinueButton;

              context.showIDBottomSheet(
                  iconPath: Assets.images.idLocationImg,
                  title: title,
                  isDismissible: false,
                  content: content,
                  primaryButtonText: primaryButtonText,
                  textButtonText: textButtonText,
                  onPrimaryButtonSelected: () {
                    if (state is LocationPermissionDeniedState) {
                      context.read<LocationBloc>().add(ShowDialogRequestPermissionEvent());
                    } else if (state is LocationPermissionDeniedForeverState) {
                      context.read<LocationBloc>().add(OpenAppSettingsEvent());
                    }
                    Navigator.of(context).pop();
                  },
                  onTextButtonSelected: () {
                    context.read<LocationBloc>().add(RequestDefaultLocationEvent());
                    Navigator.of(context).pop();
                  }
              );
            }
          },
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

          if (state is AwaitLocationPermissionFromAppSettingState ||
              state is AwaitLocationServiceSettingState) {
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

      final LocationState blocState = context.read<LocationBloc>().state;
      if (blocState is AwaitLocationServiceSettingState) {
        Navigator.of(context).pop();
      }
    }
  }
}
