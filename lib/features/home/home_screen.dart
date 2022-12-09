import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/home/widgets/date_label_view.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:nartus_location/nartus_location.dart';
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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (BuildContext context, LocationState state) {
          if (state is LocationPermissionDeniedForeverState || state is LocationPermissionDeniedState) {
            final String title = state is LocationPermissionDeniedForeverState
              ? S.of(context).locationTurnOnSuggestionTitle
              : S.of(context).locationPermissionDialogTitle;

            final String content = state is LocationPermissionDeniedForeverState
              ? S.of(context).locationTurnOnSuggestionDescription
              : S.of(context).locationPermissionDialogMessage;

            final String primaryButtonText = state is LocationPermissionDeniedForeverState
              ? S.of(context).ctaGoToSettings
              : S.of(context).locationPermissionDialogAllowButton;

            final String textButtonText = state is LocationPermissionDeniedForeverState
              ? S.of(context).ctaLocationTurnOnContinueDefaultLocation
              : S.of(context).locationPermissionDialogContinueButton;

            context.showIDBottomSheet(
              iconPath: Assets.images.idLocationImg,
              title: title,
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
              onTextButtonSelected: () => Navigator.of(context).pop(),
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.removeObserver(this);
      context.read<LocationBloc>().add(ReturnedFromAppSettingsEvent());
    }
  }
}
