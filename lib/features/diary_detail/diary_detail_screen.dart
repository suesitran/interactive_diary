// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_detail_cubit.dart';
import 'package:interactive_diary/features/diary_detail/widgets/diary_header.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
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

class DiaryDetailBody extends StatefulWidget {
  const DiaryDetailBody({Key? key}) : super(key: key);

  @override
  State<DiaryDetailBody> createState() => _DiaryDetailBodyState();
}

class _DiaryDetailBodyState extends State<DiaryDetailBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiaryDetailCubit, DiaryDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadDiaryDetailCompleted) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: DiaryHeaderAppbar(
                  avatarPath: state.contents.userPhotoUrl,
                  displayName: state.contents.userDisplayName,
                  dateTime: state.contents.dateTime,
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
                    bottom: NartusDimens.padding32),
                child: SingleChildScrollView(
                  // physics: const ClampingScrollPhysics(),
                  child: Semantics(
                    label: state.contents.plainText ?? '',
                    child: QuillEditor(
                      padding: EdgeInsets.zero,
                      controller:
                          state.contents.richText ?? QuillController.basic(),
                      readOnly: true,
                      autoFocus: true,
                      expands: false,
                      scrollable: true,
                      focusNode: FocusNode()..canRequestFocus = false,
                      scrollController: ScrollController(),
                      enableInteractiveSelection: false,
                      enableSelectionToolbar: false,
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }

  void _returnToPreviousPage(BuildContext context) {
    // WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Navigator.of(context).pop();
  }
}
