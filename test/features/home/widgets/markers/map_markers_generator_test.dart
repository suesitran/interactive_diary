import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/widgets/markers/map_markers_generator.dart';

void main() {
  test('verify setup', () async {
    final MapMarkerGenerator generator = MapMarkerGenerator(
      onCurrentLocationMarkerTapped: () {},
      onMicTapped: () {},
      onSmileyTapped: () {},
      onPenTapped: () {},
      onCameraTapped: () {},
    );

    generator.markerData.listen((event) {
      expect(event.length, 1);
    });

    generator.setup(const LatLng(0.0, 0.0));
    await Future.delayed(const Duration(milliseconds: 500));

    expect(generator.showMenu, false);
    expect(generator.smileyMenuPosition, Offset.zero);
    expect(generator.micMenuPosition, Offset.zero);
    expect(generator.penMenuPosition, Offset.zero);
    expect(generator.cameraMenuPosition, Offset.zero);
  });

  test(
    'verify menu position on animation',
    () async {
      bool stream = false;
      final MapMarkerGenerator generator = MapMarkerGenerator(
        onCurrentLocationMarkerTapped: () {},
        onMicTapped: () {},
        onSmileyTapped: () {},
        onPenTapped: () {},
        onCameraTapped: () {},
      );

      generator.markerData.listen((markers) {
        if (markers.length == 1) {
          // after setup
          return;
        }
        stream = true;
        // after calculation, come here to  verify  data
        expect(markers.length, 5);

        // camera marker
        final Marker camera = markers.firstWhere(
            (element) => element.markerId.value == menuCameraMarkerLocationId);
        expect(camera.anchor, const Offset(15, 20));

        // pen marker
        final Marker pen = markers.firstWhere(
            (element) => element.markerId.value == menuPencilMarkerLocationId);
        expect(pen.anchor, const Offset(16, 30));

        // mic marker
        final Marker mic = markers.firstWhere(
            (element) => element.markerId.value == menuVoiceMarkerLocationId);
        expect(mic.anchor, const Offset(17, 40));

        // smiley marker
        final Marker smiley = markers.firstWhere(
            (element) => element.markerId.value == menuEmojiMarkerLocationId);
        expect(smiley.anchor, const Offset(18, 50));
      });

      generator.setup(const LatLng(0.0, 0.0));
      await Future.delayed(const Duration(milliseconds: 500));

      generator.onAnimation(
          animValue: 0.8,
          cameraMenuPosition: const Offset(15, 20),
          penMenuPosition: const Offset(16, 30),
          micMenuPosition: const Offset(17, 40),
          smileyMenuPosition: const Offset(18, 50),
          showMenu: true);
      await Future.delayed(const Duration(milliseconds: 500));
      // ensures stream is triggered
      expect(stream, true);
    },
  );
}
