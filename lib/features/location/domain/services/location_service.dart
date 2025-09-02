import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';
import 'package:taukeet/features/location/domain/entities/location.dart';
import 'package:taukeet/features/location/domain/enums/location_permission_status.dart';

abstract class LocationService {
  Future<bool> isServiceEnabled();
  Future<bool> requestService();

  Future<LocationPermissionStatus> checkPermission();
  Future<LocationPermissionStatus> requestPermission();

  Future<Location> getCurrentLocation();

  Future<Address> getAddressFromCoordinates({
    required Coordinates coordinates,
    required String locale,
  });
}
