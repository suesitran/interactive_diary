import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_contents_event.dart';
part 'get_contents_state.dart';

class GetContentsBloc extends Bloc<GetContentsEvent, GetContentsState> {
  GetContentsBloc() : super(GetContentsInitialState()) {
    on<GetContentsEvent>(
        (GetContentsEvent event, Emitter<GetContentsState> emitter) async {
      _getContents(emitter);
    });
  }

  Future<void> _getContents(Emitter<GetContentsState> emitter) async {
    emitter(GettingContentsState());
    try {

    } catch (e) {

    }
  }


}