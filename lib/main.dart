import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/settings.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(AddressAdapter());

  await SettingsLibrary.populateDefaultData();

  runApp(const App());
}
