import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(flex: 2,child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(Assets.images.noConnectionBg),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(Assets.images.noConnection),
                ),
              ],
            ),
          ),),
          Expanded(flex: 3,child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(S.of(context).noConnectionTitle, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: NartusColor.dark),),
              Text(S.of(context).noConnectionMessage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: NartusColor.dark),),
            ],
          ),)
        ],
      ),
    );
  }
}
