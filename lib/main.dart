import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:taukeet/cubit/prayer_cubit.dart';
import 'package:taukeet/intro.dart';
import 'package:taukeet/service_locator.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';
import 'package:taukeet/ticker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Taukeet",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Intro(),
    );
  }
}
