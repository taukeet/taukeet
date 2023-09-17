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

  Settings({
    required this.address,
    required this.madhab,
    required this.calculationMethod,
  });

  Settings copyWith({
    Address? address,
    String? madhab,
    String? calculationMethod,
  }) {
    return Settings(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
    );
  }
}
