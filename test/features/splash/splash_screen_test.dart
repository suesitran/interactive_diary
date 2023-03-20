import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/features/splash/splash_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_screen_test.mocks.dart';
import '../../widget_tester_extension.dart';

@GenerateMocks([AppConfigBloc])
void main() {
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();

  setUp(() {
    when(appConfigBloc.stream)
        .thenAnswer((_) => Stream.value(AppConfigInitial()));
    when(appConfigBloc.state).thenAnswer((_) => AppConfigInitial());
  });

  testWidgets('verify splash UI', (widgetTester) async {
    Widget splash = const SplashScreen();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, splash);

    // verify that splash UI is just a blank screen
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
