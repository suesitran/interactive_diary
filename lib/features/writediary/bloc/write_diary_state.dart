part of 'write_diary_cubit.dart';

abstract class WriteDiaryState extends Equatable {
  const WriteDiaryState();

  @override
  List<Object> get props => [];
}

class WriteDiaryInitial extends WriteDiaryState {}

class WriteDiaryStart extends WriteDiaryState {}

class WriteDiarySuccess extends WriteDiaryState {}
