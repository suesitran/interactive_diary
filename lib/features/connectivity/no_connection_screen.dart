import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/features/connectivity/bloc/connection_screen_bloc.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionScreenBloc, ConnectionScreenState>(
      listener: (BuildContext context, ConnectionScreenState state) {
        if (state is ChangeConnectedState) {
          debugPrint('change to connect');
          context.pop();
        }
      },
      child: BlocBuilder<ConnectionScreenBloc, ConnectionScreenState>(
        builder: (BuildContext context, ConnectionScreenState state) {
          if (state is ConnectionScreenInitial) {
            context
                .read<ConnectionScreenBloc>()
                .add(ChangeConnectConnectivityEvent());
          }
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset(
                  Assets.images.noConnection,
                  fit: BoxFit.fitWidth,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        S.of(context).noConnectionTitle,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: NartusColor.dark),
                      ),
                      Text(
                        S.of(context).noConnectionMessage,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: NartusColor.dark),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
