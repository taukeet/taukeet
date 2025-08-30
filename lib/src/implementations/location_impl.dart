import 'package:geocoding/geocoding.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:location/location.dart' as geo_location;
import 'package:taukeet/features/location/domain/entities/address.dart';

class LocationImpl implements GeoLocationService {
  @override
  Future<Address> fetch({String? locale}) async {
    geo_location.Location location = geo_location.Location();

    // Check if location service is enable
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

    return getAddress(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      locale: locale,
    );
  }

  @override
  Future<Address> getAddress({
    required double latitude,
    required double longitude,
    String? locale,
  }) async {
    await setLocaleIdentifier(locale ?? "en");

    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    final String addressStr = _makeAddress(placemarks.first);

    return Address(
      latitude: latitude,
      longitude: longitude,
      address: addressStr.isEmpty ? "$latitude, $longitude" : addressStr,
    );
  }

  String _makeAddress(Placemark placemark) {
    final components = [placemark.locality, placemark.country];

    // Filter out null and empty strings, then join with ", " separator
    final filteredComponents =
        components.where((component) => component?.isNotEmpty == true);

    // Join the filtered components into a single string with ", " separator
    final address = filteredComponents.join(', ');

    return address;
  }
}
