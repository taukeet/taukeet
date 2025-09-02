import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart' as geo_location;
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';
import 'package:taukeet/features/location/domain/entities/location.dart'
    as location;
import 'package:taukeet/features/location/domain/enums/location_permission_status.dart';
import 'package:taukeet/features/location/domain/services/location_service.dart';

@LazySingleton(as: LocationService)
class GeocodingServiceImpl implements LocationService {
  final geo_location.Location _location = geo_location.Location();

  @override
  Future<bool> isServiceEnabled() => _location.serviceEnabled();

  @override
  Future<bool> requestService() => _location.requestService();

  @override
  Future<LocationPermissionStatus> checkPermission() async {
    final status = await _location.hasPermission();

    return _mapPermission(status);
  }

  @override
  Future<LocationPermissionStatus> requestPermission() async {
    final status = await _location.requestPermission();

    return _mapPermission(status);
  }

  @override
  Future<location.Location> getCurrentLocation() async {
    final locationData = await _location.getLocation();

    if (locationData.latitude == null && locationData.longitude == null) {
      throw Exception("Latitude or Longitude not found");
    }

    return location.Location(
      coordinates: Coordinates(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      ),
    );
  }

  @override
  Future<Address> getAddressFromCoordinates({
    required Coordinates coordinates,
    required String locale,
  }) async {
    await setLocaleIdentifier(locale);

    final placemarks = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    final addressStr = _makeAddress(placemarks.first);

    return Address(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      address: addressStr.isEmpty
          ? "${coordinates.latitude}, ${coordinates.longitude}"
          : addressStr,
    );
  }

  LocationPermissionStatus _mapPermission(
      geo_location.PermissionStatus status) {
    switch (status) {
      case geo_location.PermissionStatus.granted:
        return LocationPermissionStatus.granted;
      case geo_location.PermissionStatus.grantedLimited:
        return LocationPermissionStatus.grantedLimited;
      case geo_location.PermissionStatus.denied:
        return LocationPermissionStatus.denied;
      case geo_location.PermissionStatus.deniedForever:
        return LocationPermissionStatus.deniedForever;
    }
  }

  String _makeAddress(Placemark placemark) {
    final components = [placemark.locality, placemark.country];
    final filteredComponents =
        components.where((component) => component?.isNotEmpty == true);

    return filteredComponents.join(', ');
  }
}
