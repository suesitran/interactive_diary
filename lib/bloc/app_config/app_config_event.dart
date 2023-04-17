part of 'app_config_bloc.dart';

abstract class AppConfigEvent {}

class AppRequestInitialise extends AppConfigEvent {}

class AnnounceShakeAction extends AppConfigEvent {}

class CancelFirstLaunch extends AppConfigEvent {}
