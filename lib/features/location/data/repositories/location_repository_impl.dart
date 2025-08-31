import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as geo_location;
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Address> getCurrentLocation(String locale) async {
    final location = geo_location.Location();

    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationDisabledException();
      }
    }

    // Check if permission is granted
    geo_location.PermissionStatus permissionGranted =
        await location.hasPermission();
    if (permissionGranted == geo_location.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != geo_location.PermissionStatus.granted) {
        throw LocationPermissionDenied();
      }
    }

    final locationData = await location.getLocation();

    return getAddressFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
      locale,
    );
  }

  @override
  Future<Address> getAddressFromCoordinates(
    double latitude,
    double longitude,
    String locale,
  ) async {
    await _setLocaleIdentifier(locale);

    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    final addressStr = _makeAddress(placemarks.first);

    return Address(
      latitude: latitude,
      longitude: longitude,
      address: addressStr.isEmpty ? "$latitude, $longitude" : addressStr,
    );
  }

  Future<void> _setLocaleIdentifier(String locale) async {
    // geocoding package allows locale via `placemarkFromCoordinates` optional param
    // If needed, you can wrap platform-specific locale settings here
  }

  String _makeAddress(Placemark placemark) {
    final components = [placemark.locality, placemark.country];
    final filteredComponents =
        components.where((component) => component?.isNotEmpty == true);
    return filteredComponents.join(', ');
  }
}
