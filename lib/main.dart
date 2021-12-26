import 'package:flutter/material.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/home.dart';
import 'package:taukeet/intro.dart';
import 'package:taukeet/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final StorageService storageService = getIt<StorageService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Taukeet",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: storageService.getString("madhab") != null &&
              storageService.getString("calculationMethod") != null &&
              storageService.getDouble("latitude") != null &&
              storageService.getDouble("longitude") != null
          ? Home()
          : const Intro(),
    );
  }
}
