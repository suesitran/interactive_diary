part of "../nartus_location.dart";

class LocationException implements Exception {}

class LocationServiceDisableException extends LocationException {}

class LocationPermissionDeniedException extends LocationException {}

class LocationPermissionDeniedForeverException extends LocationException {}

class LocationDataCorruptedException extends LocationException {}
