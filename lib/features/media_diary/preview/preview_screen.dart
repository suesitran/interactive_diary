import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/media_diary/preview/bloc/preview_interaction_cubit.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';

class PreviewScreen extends StatelessWidget {
  final String path;
  const PreviewScreen(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreviewInteractionCubit>(
      create: (context) => PreviewInteractionCubit(),
      child: BlocListener<PreviewInteractionCubit, PreviewInteractionState>(
        listener: (context, state) {
          if (state is OnFileDeleted) {
            context.pop();
          }
        },
        child: Scaffold(
          body: Container(
            color: NartusColor.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * .8,
                        decoration: BoxDecoration(
                            color: NartusColor.secondaryContainer,
                            borderRadius: const BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(NartusDimens.padding24),
                              bottomRight:
                                  Radius.circular(NartusDimens.padding24),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(path))))),
                    Positioned(
                        top: 0,
                        left: NartusDimens.padding16,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: NartusDimens.padding16),
                            child: Builder(builder: (context) {
                              return CircleButton(
                                size: NartusDimens.padding40,
                                iconPath: Assets.images.closeIcon,
                                semantic: S.current.close,
                                onPressed: () => context
                                    .read<PreviewInteractionCubit>()
                                    .onCancelPreview(path),
                              );
                            }),
                          ),
                        )),
                  ],
                ),
                Expanded(
                  child: Center(
                      child: NartusButton.primary(
                    label: S.current.save,
                    onPressed: () {},
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
