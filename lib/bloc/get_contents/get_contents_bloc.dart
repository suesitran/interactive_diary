import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_contents_event.dart';
part 'get_contents_state.dart';

class GetContentsBloc extends Bloc<GetContentsEvent, GetContentsState> {
  GetContentsBloc() : super(GetContentsInitialState()) {
    on<GettingContentsEvent>(
        (GettingContentsEvent event, Emitter<GetContentsState> emitter) async {
      await _getContents(emitter);
    });
  }

  Future<void> _getContents(Emitter<GetContentsState> emitter) async {
    print('HERE');
    emitter(GettingContentsState());
    try {
      await Future.delayed(Duration(seconds: 1));
      final contents = [];
      if (contents.isEmpty) {
        emitter(GetContentsEmptyState());
      } else {
        emitter(GetContentsSucceedState(contents));
      }
    } catch (e) {
      emitter(GetContentsFailedState(e.toString()));
    }
  }

  void getContents() {
    add(GettingContentsEvent());
  }
}