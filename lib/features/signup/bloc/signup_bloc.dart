import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState());
}

abstract class SignUpEvent {}

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}
