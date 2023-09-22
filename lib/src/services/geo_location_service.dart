import 'package:taukeet/src/entities/address.dart';

abstract class GeoLocationService {
  Future<Address> fetch();
}
