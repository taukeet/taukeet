import 'package:hive/hive.dart';
import 'package:taukeet/src/entities/address.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  Address address;

  Settings({required this.address});
}
