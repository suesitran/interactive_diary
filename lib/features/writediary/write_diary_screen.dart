import 'package:flutter/cupertino.dart';
import 'package:interactive_diary/features/writediary/id_write_diary.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
        child: const IDWriteDiary()
    );
  }
}