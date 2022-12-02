part of 'write_diary_cubit.dart';

abstract class WriteDiaryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[];
}

class WriteDiaryInitial extends WriteDiaryState {}

class SaveDiarySucceeded extends WriteDiaryState {}

class SaveDiaryFailed extends WriteDiaryState {}
