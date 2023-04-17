import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/writediary/bloc/write_diary_cubit.dart';
import 'package:interactive_diary/features/writediary/widgets/advance_text_editor_view.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/widgets/location_view.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen(
      {required this.latLng,
      required this.address,
      required this.business,
      Key? key})
      : super(key: key);

  final LatLng latLng;
  final String? address;
  final String? business;

  @override
  Widget build(BuildContext context) => BlocProvider<WriteDiaryCubit>(
        create: (context) => WriteDiaryCubit(),
        child: WriteDiaryBody(
          latLng: latLng,
          address: address,
          business: business,
        ),
      );
}

class WriteDiaryBody extends StatelessWidget {
  final LatLng latLng;
  final String? address;
  final String? business;

  WriteDiaryBody(
      {required this.latLng,
      required this.address,
      required this.business,
      Key? key})
      : super(key: key);

  final ValueNotifier<String> _isTextWritten = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteDiaryCubit, WriteDiaryState>(
      listener: (BuildContext context, WriteDiaryState state) {
        if (state is WriteDiarySuccess) {
          _returnToPreviousPage(context);
          return;
        }

        if (state is WriteDiaryStart) {}
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.addText,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: NartusColor.dark)),
          backgroundColor: NartusColor.background,
          leading: NartusButton.text(
            iconPath: Assets.images.back,
            iconSemanticLabel: S.current.back,
            onPressed: () {
              _returnToPreviousPage(context);
            },
          ),
          elevation: 0.0,
          actions: <Widget>[
            ValueListenableBuilder<String>(
                valueListenable: _isTextWritten,
                builder: (_, text, __) => NartusButton.text(
                    onPressed: text.isNotEmpty
                        ? () {
                            context.read<WriteDiaryCubit>().saveTextDiary(
                                  title: '',
                                  textContent: text,
                                  latLng: latLng,
                                );
                          }
                        : null,
                    label: S.current.save)),
          ],
        ),
        body: AdvanceTextEditorView(
          leading: LocationView(
            address: address,
            businessName: business,
            latitude: latLng.lat,
            longitude: latLng.long,
          ),
          onTextChange: (text) => _isTextWritten.value = text,
        ),
      ),
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    _isTextWritten.dispose();

    /// TODO this is a cheat.
    /// We need to wait for keyboard to be fully dismissed before returning to previous page
    Future<void>.delayed(const Duration(milliseconds: 500))
        .then((_) => Navigator.of(context).pop());
  }
}
