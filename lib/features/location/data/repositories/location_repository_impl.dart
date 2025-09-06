import 'package:injectable/injectable.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';
import 'package:taukeet/features/location/domain/services/location_service.dart';
import 'package:taukeet/features/location/domain/enums/location_permission_status.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationService _locationService;

  LocationRepositoryImpl(this._locationService);

  @override
  Future<Address> getCurrentLocation(String locale) async {
    // Check if location service is enabled
    bool serviceEnabled = await _locationService.isServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        throw LocationDisabledException();
      }
    }

    // Check and request permission if needed
    LocationPermissionStatus permissionStatus =
        await _locationService.checkPermission();
    if (permissionStatus == LocationPermissionStatus.denied ||
        permissionStatus == LocationPermissionStatus.deniedForever) {
      permissionStatus = await _locationService.requestPermission();
      if (permissionStatus != LocationPermissionStatus.granted &&
          permissionStatus != LocationPermissionStatus.grantedLimited) {
        throw LocationPermissionDenied();
      }
    }

    // Get current location
    final location = await _locationService.getCurrentLocation();

    // Get address for the current location
    final address = await _locationService.getAddressFromCoordinates(
      coordinates: location.coordinates,
      locale: locale,
    );

    return address;
  }

  @override
  Future<Address> getAddressFromCoordinates(
    double latitude,
    double longitude,
    String locale,
  ) async {
    final coordinates = Coordinates(latitude: latitude, longitude: longitude);

    return await _locationService.getAddressFromCoordinates(
      coordinates: coordinates,
      locale: locale,
    );
  }
}
