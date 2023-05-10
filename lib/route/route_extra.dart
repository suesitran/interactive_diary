import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:nartus_storage/nartus_storage.dart';

class WriteDiaryExtra {
  final LatLng latLng;
  final String? address;
  final String? business;

  WriteDiaryExtra(this.latLng, this.address, this.business);
}
