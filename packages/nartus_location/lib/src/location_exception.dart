part of "../nartus_location.dart";

class LocationException implements Exception {}

class LocationServiceDisableException extends LocationException {}

class LocationPermissionNotGrantedException extends LocationException {}

class LocationDataCorruptedException extends LocationException {}
