part of '../nartus_location.dart';

class LocationDetails {
  double latitude;
  double longitude;

  LocationDetails(this.latitude, this.longitude);
}

enum PermissionStatusDiary { granted, denied, deniedForever }
