import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:taukeet/cubit/prayer_cubit.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';
import 'package:taukeet/ticker.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final prayerService = AdhanPrayerService(
    coordinates: Coordinates(21.1458, 79.0882),
    params: CalculationMethod.karachi.getParameters(),
    madhab: Madhab.hanafi,
  );

  final cardTimeStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xff191923),
  );

  final cardTimeLabelStyle = const TextStyle(
    fontSize: 8,
    color: Color(0xff191923),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(
          create: (context) =>
              TimerBloc(ticker: const Ticker(), prayerService: prayerService)
                ..add(const TimerStarted()),
        ),
        BlocProvider<PrayerCubit>(
          create: (context) => PrayerCubit(
            prayerService: prayerService,
          )..initialize(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff191923),
        body: Stack(
          children: [
            Positioned(
              top: 30,
              right: 10,
              child: IconButton(
                onPressed: () {
                  print("clicked");
                },
                iconSize: 26,
                icon: const Icon(
                  Icons.settings,
                  color: Color(0xffF0E7D8),
                ),
              ),
            ),
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
                              (prayer) => Padding(
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Card(
                                  color: const Color(0xffF0E7D8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          prayer.prayer.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 6,
                                            color: Color(0xff191923),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "START",
                                                  style: cardTimeLabelStyle,
                                                ),
                                                Text(
                                                  DateFormat("hh:mm a")
                                                      .format(prayer.startTime),
                                                  style: cardTimeStyle,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "END",
                                                  style: cardTimeLabelStyle,
                                                ),
                                                Text(
                                                  DateFormat("hh:mm a")
                                                      .format(prayer.endTime),
                                                  style: cardTimeStyle,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final hourStr = (duration / 3600).floor().toString().padLeft(2, "0");
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$hourStr:$minutesStr:$secondsStr',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        letterSpacing: 8,
        color: Color(0xffF0E7D8),
      ),
    );
  }
}
