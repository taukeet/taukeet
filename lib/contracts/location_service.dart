import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<Position> currentPosition();
  Future<Placemark> positionAddress(double latitude, double longitude);
}
