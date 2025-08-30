import 'package:taukeet/src/entities/address.dart';

abstract class GeoLocationService {
  Future<Address> fetch({String? locale});
  Future<Address> getAddress({
    required double latitude,
    required double longitude,
    String? locale,
  });
}
