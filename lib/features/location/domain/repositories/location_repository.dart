import 'package:taukeet/features/location/domain/entities/address.dart';

abstract class LocationRepository {
  Future<Address> getCurrentLocation(String locale);
  Future<Address> getAddressFromCoordinates(
    double latitude,
    double longitude,
    String locale,
  );
}
