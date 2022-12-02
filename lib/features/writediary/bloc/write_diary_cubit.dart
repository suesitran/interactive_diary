import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_diary_state.dart';

class WriteDiaryCubit extends Cubit<WriteDiaryState> {
  WriteDiaryCubit() : super(WriteDiaryInitial());
}
