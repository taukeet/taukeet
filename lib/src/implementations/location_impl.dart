import 'package:geocoding/geocoding.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:location/location.dart' as geo_location;
import 'package:taukeet/src/entities/address.dart';

class LocationImpl implements GeoLocationService {
  @override
  Future<Address> fetch() async {
    geo_location.Location location = geo_location.Location();

    // Check if location service is enable
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception();
      }
    }

    // Check if permission is granted
    geo_location.PermissionStatus permissionGranted =
        await location.hasPermission();
    if (permissionGranted == geo_location.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != geo_location.PermissionStatus.granted) {
        throw Exception();
      }
    }

    final locationData = await location.getLocation();
    final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    final String addressStr = _makeAddress(placemarks.first);

    return Address(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      address: addressStr.isEmpty
          ? "${locationData.latitude}, ${locationData.longitude}"
          : addressStr,
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
