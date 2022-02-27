import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/cubit/prayer_cubit.dart';
import 'package:taukeet/service_locator.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';
import 'package:taukeet/widgets/partials/prayer_card.dart';
import 'package:taukeet/widgets/partials/timer_text.dart';
import 'package:taukeet/widgets/settings.dart';

class Home extends StatelessWidget {
  final prayerService = getIt<PrayerService>();
  final storageService = getIt<StorageService>();

  Home({Key? key}) : super(key: key) {
    prayerService.refreshTimes(storageService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191923),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<PrayerCubit, PrayerState>(
                    builder: (context, state) {
                      return Text(
                        state.currentPrayer?.prayer.toUpperCase() ?? "none",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          color: Color(0xffF0E7D8),
                        ),
                      );
                    },
                  ),
                  const TimerText(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 196),
                child: BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: state.prayerTimes
                          .map(
                            (prayer) => PrayerCard(
                              prayer: prayer,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              iconSize: 26,
              icon: const Icon(
                Icons.settings,
                color: Color(0xffF0E7D8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
