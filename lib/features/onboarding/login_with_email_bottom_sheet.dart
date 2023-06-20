import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/generated/l10n.dart';

import 'package:interactive_diary/features/onboarding/login_options.dart';

class LoginWithEmailBottomSheet extends StatelessWidget {
  const LoginWithEmailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            NartusDimens.padding32,
            NartusDimens.padding8,
            NartusDimens.padding32,
            NartusDimens.padding40),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    height: NartusDimens.size2,
                    width: NartusDimens.size50,
                    color: NartusColor.grey,
                  ),
                ),
                const SizedBox(height: NartusDimens.padding32),
                ExcludeSemantics(
                  child: SvgPicture.asset(
                    Assets.images.idLoginWithEmail,
                    width: NartusDimens.size80,
                    height: NartusDimens.size80,
                  ),
                ),
                const SizedBox(height: NartusDimens.padding24),
                Text(
                  S.current.loginWithEmail,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: NartusColor.dark),
                ),
                const SizedBox(height: NartusDimens.padding24),
                Text(
                  S.current.yourEmail,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: NartusColor.dark),
                ),
                const SizedBox(height: NartusDimens.padding8),
                TextField(
                  // style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: S.current.enterYourEmail,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: NartusDimens.padding16),
                Text(
                  S.current.password,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: NartusColor.dark),
                ),
                const SizedBox(height: NartusDimens.padding8),
                TextField(
                  // style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: S.current.enterPassword,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: NartusDimens.padding16),
                Text(
                  S.current.forgotPassword,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: NartusColor.primary),
                ),
                const SizedBox(height: NartusDimens.padding16),
                NartusButton.primary(
                  label: S.current.login,
                ),
                const SizedBox(height: NartusDimens.padding24),
                Center(
                  child: Text(
                    S.current.orLoginWith,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: NartusColor.grey),
                  ),
                ),
                const SizedBox(height: NartusDimens.padding24),
                const LoginOptions(),
              ],
            ),
          ),
        ));
  }
}

extension LoginEmailBottomSheet on BuildContext {
  void showLoginWithEmailBottomSheet() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: this,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(NartusDimens.radius32))),
        builder: (BuildContext builder) {
          return const LoginWithEmailBottomSheet();
        });
  }
}
