import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_display_content_cubit.dart';
import 'package:interactive_diary/features/diary_detail/widgets/picture_diary_detail_screen.dart';
import 'package:interactive_diary/features/diary_detail/widgets/text_diary_detail_screen.dart';
import 'package:interactive_diary/features/diary_detail/widgets/video_diary_detail_screen.dart';

class DiaryDetailView extends StatelessWidget {
  final DateTime dateTime;
  final String countryCode;
  final String postalCode;
  const DiaryDetailView(
      {required this.dateTime,
      required this.countryCode,
      required this.postalCode,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<DiaryDisplayContentCubit>(
        create: (context) => DiaryDisplayContentCubit()
          ..fetchDiaryDisplayContent(dateTime, countryCode, postalCode),
        child: Scaffold(
          body: BlocBuilder<DiaryDisplayContentCubit, DiaryDisplayContentState>(
            builder: (context, state) {
              if (state is TextDiaryContent) {
                return TextDiaryDetailScreen(
                  jsonText: state.jsonContent,
                  displayName: state.displayName,
                  photoUrl: state.photoUrl,
                  dateTime: state.dateTime,
                );
              }

              if (state is ImageDiaryContent) {
                return PictureDiaryDetailScreen(
                  displayName: state.displayName,
                  dateTime: state.dateTime,
                  photoUrl: state.photoUrl,
                  imageUrl: state.imagePath,
                );
              }

              if (state is VideoDiaryContent) {
                return VideoDiaryDetailScreen(
                  dateTime: state.dateTime,
                  displayName: state.displayName,
                  photoUrl: state.photoUrl,
                  videoPath: state.videoPath,
                );
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      );
}
