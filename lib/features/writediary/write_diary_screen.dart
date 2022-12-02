import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/writediary/bloc/write_diary_cubit.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/writediary/location.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<WriteDiaryCubit>(
        create: (_) => WriteDiaryCubit(),
        child: _WriteDiaryBody(),
      );
}

class _WriteDiaryBody extends StatelessWidget {
  _WriteDiaryBody({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isTextWritten = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addText,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: NartusColor.dark)),
        backgroundColor: NartusColor.background,
        leading: NartusButton.text(
          iconPath: Assets.images.back,
          iconSemanticLabel: S.of(context).back,
          onPressed: () {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

            /// TODO this is a cheat.
            /// We need to wait for keyboard to be fully dismissed before returning to previous page
            Future<void>.delayed(const Duration(milliseconds: 500))
                .then((_) => Navigator.of(context).pop());
          },
        ),
        elevation: 0.0,
        actions: <Widget>[
          ValueListenableBuilder<bool>(
              valueListenable: _isTextWritten,
              builder: (_, bool enable, __) => NartusButton.text(
                  onPressed: enable ? () {} : null, label: S.of(context).save)),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const LocationView(
            currentLocation:
                'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia'),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            autofocus: true,
            showCursor: true,
            maxLines: null,
            decoration: const InputDecoration(border: InputBorder.none),
            style: Theme.of(context).textTheme.bodyText2,
            keyboardType: TextInputType.multiline,
            onChanged: (String text) {
              final bool textAvailable = text.isNotEmpty;

              if (_isTextWritten.value != textAvailable) {
                _isTextWritten.value = textAvailable;
              }
            },
          ),
        ))
      ]),
    );
  }
}
