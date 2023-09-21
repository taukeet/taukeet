import 'package:hive/hive.dart';
import 'package:taukeet/src/entities/address.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  Address address;

  @HiveField(1)
  String madhab;

  @HiveField(2)
  String calculationMethod;

  @HiveField(3)
  String higherLatitude;

  Settings({
    required this.address,
    required this.madhab,
    required this.calculationMethod,
    required this.higherLatitude,
  });

  Settings copyWith({
    Address? address,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
  }) {
    return Settings(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
    );
  }
}
