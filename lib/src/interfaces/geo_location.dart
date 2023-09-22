import 'package:taukeet/src/entities/address.dart';

abstract class GeoLocation {
  Future<Address> fetch();
}
