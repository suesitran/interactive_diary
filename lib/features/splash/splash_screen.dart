import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/route/route_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        // TODO implement Splash screen here
        body: MultiBlocListener(listeners: [
          BlocListener<AppConfigBloc, AppConfigState>(
            listener: (BuildContext context, AppConfigState state) {
              if (state is AppConfigInitialised) {
                if (state.isFirstLaunch) {
                  context.goToOnboarding();
                } else {
                  context.goToHome();
                }
              }
            },
          ),
        ], child: const SizedBox.shrink()),
      );
}
