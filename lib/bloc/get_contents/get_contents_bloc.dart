import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_contents_event.dart';
part 'get_contents_state.dart';

class GetContentsBloc extends Bloc<GetContentsEvent, GetContentsState> {
  GetContentsBloc() : super(GetContentsInitialState()) {
    on<GetLocationContentsEvent>((GetLocationContentsEvent event,
        Emitter<GetContentsState> emitter) async {
      await _getContents(emitter);
    });
  }

  Future<void> _getContents(Emitter<GetContentsState> emitter) async {
    emitter(GettingContentsState());
    try {
      // TODO implement query data from database
      await Future<void>.delayed(const Duration(seconds: 1));
      final List<String> contents = <String>[
        'abc',
        '123123',
        'xwxzxz',
        'cdvvfvjnf',
        'eiwn2321'
      ];
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
    add(GetLocationContentsEvent());
  }
}
