import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() {
        // called using hardware back behaviour,
        // if user taps back button when no internet connection,
        // then exit app.
        SystemNavigator.pop(animated: true);
        return false;
      }),
      child: Scaffold(
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
                    S.current.noConnectionTitle,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: NartusColor.dark),
                  ),
                  Text(
                    S.current.noConnectionMessage,
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
      ),
    );
  }
}

extension DisconnectedOverlayExtension on BuildContext {
  void showDisconnectedOverlay() {
    GoRouter.of(this).push(noConnectionRoute);
  }

  void hideDisconnectedOverlay() {
    if (GoRouter.of(this).location == noConnectionRoute) {
      GoRouter.of(this).pop();
    }
  }
}
