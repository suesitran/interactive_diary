// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_detail_cubit.dart';
import 'package:interactive_diary/features/diary_detail/widgets/diary_header.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<DiaryDetailCubit>(
        create: (context) => DiaryDetailCubit()..loadDiaryDetail(),
        child: const DiaryDetailBody(),
      );
}

class DiaryDetailBody extends StatelessWidget {
  const DiaryDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: BlocBuilder<DiaryDetailCubit, DiaryDetailState>(
          builder: (context, state) {
            String? avatarPath = '';
            String? displayName = '';
            DateTime dateTime = DateTime.now();
            if (state is LoadDiaryDetailCompleted) {
              displayName = state.contents.userDisplayName;
              avatarPath = state.contents.userPhotoUrl;
              dateTime = state.contents.dateTime;
            }
            return DiaryHeaderAppbar(
              avatarPath: avatarPath,
              displayName: displayName,
              dateTime: dateTime,
            );
          },
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
          child: BlocBuilder<DiaryDetailCubit, DiaryDetailState>(
            builder: (context, state) {
              QuillController? richText = QuillController.basic();
              if (state is LoadDiaryDetailCompleted) {
                Document? document = Document.fromJson(state.textJson);
                richText = QuillController(
                    document: document,
                    selection: const TextSelection.collapsed(offset: 0));
              }
              return Semantics(
                child: QuillEditor(
                  padding: EdgeInsets.zero,
                  controller: richText,
                  readOnly: true,
                  autoFocus: true,
                  expands: false,
                  scrollable: true,
                  focusNode: FocusNode()..canRequestFocus = false,
                  scrollController: ScrollController(),
                  enableInteractiveSelection: false,
                  enableSelectionToolbar: false,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
