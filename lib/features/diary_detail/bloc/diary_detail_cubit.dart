import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'diary_detail_state.dart';

class DiaryDetailCubit extends Cubit<DiaryDetailState> {
  DiaryDetailCubit() : super(DiaryDetailInitial());
}
