import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_diary_state.dart';

class WriteDiaryCubit extends Cubit<WriteDiaryState> {
  WriteDiaryCubit() : super(WriteDiaryInitial());

  void saveTextDiary(String text) async {
    await Future.delayed(Duration(milliseconds: 100));

    // emit state that save success
    emit(SaveDiarySucceeded());
  }
}
