import 'package:hive/hive.dart';

part 'address.g.dart'; // You'll need to generate this file using `hive_generator`

@HiveType(typeId: 2)
class Address extends HiveObject {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  String address;

  Address({
    this.latitude = 24.524654,
    this.longitude = 39.569183,
    this.address = "Al-Madinah al-Munawwarah, Saudi Arabia",
  });
}
