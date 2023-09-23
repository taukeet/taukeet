class LocationDisabledException implements Exception {
  final String message;

  LocationDisabledException([this.message = 'Location services are disabled']);

  @override
  String toString() {
    return 'LocationDisabledException: $message';
  }
}
