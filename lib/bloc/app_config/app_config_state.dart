part of 'app_config_bloc.dart';

abstract class AppConfigState extends Equatable {}

class AppConfigInitial extends AppConfigState {
  @override
  List<Object?> get props => [];
}

class AppConfigInitialised extends AppConfigState {
  final bool isFirstLaunch;

  AppConfigInitialised({required this.isFirstLaunch});

  @override
  List<Object?> get props => [isFirstLaunch];
}

class ShakeDetected extends AppConfigState {
  final int shakeTime;
  ShakeDetected(this.shakeTime);

  @override
  List<Object?> get props => [shakeTime];
}

class AppFirstLaunchCleared extends AppConfigState {
  @override
  List<Object?> get props => [];
}
