// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_detail_cubit.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
import 'package:interactive_diary/features/diary_detail/widgets/content_card_appbar.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({required this.displayContent, Key? key})
      : super(key: key);

  final DiaryDisplayContent? displayContent;

  @override
  Widget build(BuildContext context) => BlocProvider<DiaryDetailCubit>(
        create: (context) => DiaryDetailCubit(),
        child: DiaryDetailBody(
          displayContent: displayContent,
        ),
      );
}

class DiaryDetailBody extends StatefulWidget {
  final DiaryDisplayContent? displayContent;
  const DiaryDetailBody({required this.displayContent, Key? key})
      : super(key: key);
  @override
  State<DiaryDetailBody> createState() => _DiaryDetailBodyState();
}

class _DiaryDetailBodyState extends State<DiaryDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ContentCardAppBarView(
          displayName: widget.displayContent?.userDisplayName ?? '',
          photoUrl: widget.displayContent?.userPhotoUrl ?? '',
          dateTime: widget.displayContent?.dateTime ?? DateTime.now(),
        ),
        backgroundColor: NartusColor.background,
        leading: NartusButton.text(
          iconPath: Assets.images.back,
          iconSemanticLabel: S.of(context).back,
          onPressed: () {
            _returnToPreviousPage(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: NartusDimens.padding16,
            right: NartusDimens.padding16,
            bottom: NartusDimens.padding16),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Semantics(
            label: widget.displayContent?.plainText,
            child: QuillEditor.basic(
              readOnly: false,
              controller: QuillController(
                  document: widget.displayContent?.document ?? Document(),
                  selection: const TextSelection.collapsed(offset: 0)),
            ),
          ),
        ),
      ),
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    /// TODO this is a cheat.
    /// We need to wait for keyboard to be fully dismissed before returning to previous page
    Future<void>.delayed(const Duration(milliseconds: 500))
        .then((_) => Navigator.of(context).pop());
  }
}
