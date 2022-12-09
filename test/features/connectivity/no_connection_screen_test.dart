import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/bloc/no_connection_screen/connection_screen_bloc.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_tester_extension.dart';

import 'no_connection_screen_test.mocks.dart';

@GenerateMocks(<Type>[ConnectionScreenBloc])
void main() {
  final MockConnectionScreenBloc connectionScreenBloc = MockConnectionScreenBloc();

  setUpAll(() {
    when(connectionScreenBloc.state).thenAnswer((_) => ConnectionScreenInitial());
    when(connectionScreenBloc.stream).thenAnswer((_) => Stream<ConnectionScreenState>.value(ConnectionScreenInitial()));
  });

  testWidgets('Verify UI of No connection screen',
      (WidgetTester widgetTester) async {
    const NoConnectionScreen widget = NoConnectionScreen();

    await widgetTester.blocWrapAndPump<ConnectionScreenBloc>(
      connectionScreenBloc,
        widget);

    // verify screen components
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text('Whoops!'), findsOneWidget);
    expect(
        find.text(
            'Slow or no internet connections.\nPlease check your internet settings'),
        findsOneWidget);

    // verify image fitting
    SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
    expect(svgPicture.fit, BoxFit.fitWidth);
  });
}
