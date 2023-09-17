import 'package:hive/hive.dart';
import 'package:taukeet/src/entities/address.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  Address address;

  @HiveField(1)
  String madhab;

  Settings({required this.address, required this.madhab});

  Settings copyWith({
    Address? address,
    String? madhab,
  }) {
    return Settings(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
    );
  }
}
