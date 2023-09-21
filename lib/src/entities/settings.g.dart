// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      address: fields[0] as Address,
      madhab: fields[1] as String,
      calculationMethod: fields[2] as String,
      higherLatitude: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.madhab)
      ..writeByte(2)
      ..write(obj.calculationMethod)
      ..writeByte(3)
      ..write(obj.higherLatitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
