import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/gen/assets.gen.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            Assets.images.noConnection,
            fit: BoxFit.fitHeight,
          ),
          // const Gap.v20(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: NartusDimens.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to InnerME 🙌', style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: NartusColor.primary),),
                const Gap.v12(),
                Text('Discover all the cool features right now', style:Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: NartusColor.dark)),
                const Gap.v12(),
                const Gap.v20(),
                SizedBox(
                  width: double.infinity,
                  child: NartusButton.primary(label: 'Get Started', onPressed: () {},),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (131 / 812),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
