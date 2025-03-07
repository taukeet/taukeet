import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/implementations/location_impl.dart';
import 'package:taukeet/src/services/geo_location_service.dart';

// Provider for GeoLocationService
final geoLocationProvider = Provider<GeoLocationService>((ref) {
  return LocationImpl();
});