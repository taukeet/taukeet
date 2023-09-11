import 'package:flutter/material.dart';
import 'package:taukeet/src/libraries/prayer_time_library.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final PrayerTimeLibrary library = const PrayerTimeLibrary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "12:02 AM",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 12,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Nagpur, India",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Icon(
                      Icons.settings,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Fajr",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "05:30:45",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "فجر",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_left_rounded,
                          size: 44,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "THURSDAY 04 MAY",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                "20 safar 1430",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_rounded,
                          size: 44,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final PrayerTime prayer =
                                library.prayerTimes[index];

                            return Text('ok');

                            // return Row(
                            //   children: [
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         prayer.name,
                            //         style: const TextStyle(
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 2,
                            //       child: Text(
                            //         prayer.time,
                            //         textAlign: TextAlign.center,
                            //         style: const TextStyle(
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         prayer.secondName(prayer.name),
                            //         textAlign: TextAlign.right,
                            //         style: const TextStyle(
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: library.prayerTimes.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
