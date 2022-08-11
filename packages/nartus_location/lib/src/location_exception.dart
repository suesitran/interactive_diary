part of "../nartus_location.dart";

class LocationException implements Exception {}

class LocationServiceDisableException extends LocationException {}

class LocationPermissionNotGranted extends LocationException {}

class LocationDataCorrupted extends LocationException {}