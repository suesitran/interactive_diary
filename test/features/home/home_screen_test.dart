import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';

import '../../widget_tester_extension.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks(<Type>[LocationBloc])
void main() {
  final LocationBloc mockLocationBloc = MockLocationBloc();

  testWidgets('When State is LocationReadyState, then GoogleMap is presented',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(LocationDetails(0.0, 0.0), '17-07-2022')));
    when(mockLocationBloc.state).thenAnswer(
        (_) => LocationReadyState(LocationDetails(0.0, 0.0), '17-07-2022'));

    await widgetTester.blocWrapAndPump<LocationBloc>(mockLocationBloc, widget);

    expect(find.byType(GoogleMap), findsOneWidget);
  });

  testWidgets(
      'When state is LocationInitial, then CircularProgressIndicator is presented',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationInitial(PermissionStatusDiary.denied)));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationInitial(PermissionStatusDiary.denied));

    await widgetTester.blocWrapAndPump<LocationBloc>(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
