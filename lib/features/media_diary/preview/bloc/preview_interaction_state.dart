part of 'preview_interaction_cubit.dart';

abstract class PreviewInteractionState extends Equatable {
  const PreviewInteractionState();
}

class PreviewInteractionInitial extends PreviewInteractionState {
  @override
  List<Object> get props => [];
}

class OnFileDeleted extends PreviewInteractionState {
  @override
  List<Object?> get props => [];
}
