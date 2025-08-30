class LocationPermissionDenied implements Exception {
  final String message;

  LocationPermissionDenied([this.message = 'Location permission denied']);

  @override
  String toString() {
    return 'LocationPermissionDenied: $message';
  }
}
