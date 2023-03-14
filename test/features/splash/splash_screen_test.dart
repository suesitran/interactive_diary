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

    expect(
        find.ancestor(
            of: find.byType(Image),
            matching: find.descendant(
                of: find.byType(Scaffold), matching: find.byType(Container))),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Container), matching: find.byType(Image)),
        findsOneWidget);

    // verify layout of Container
    Container container = widgetTester.widget(find.ancestor(
        of: find.byType(Image),
        matching: find.descendant(
            of: find.byType(Scaffold), matching: find.byType(Container))));
    expect(container.alignment, Alignment.center);

    Image image = widgetTester.widget(find.descendant(
        of: find.byType(Container), matching: find.byType(Image)));
    expect(image.image, isA<AssetImage>());

    AssetImage assetImage = image.image as AssetImage;
    expect(assetImage.assetName, 'assets/images/splash_screen.png');
  });
}
