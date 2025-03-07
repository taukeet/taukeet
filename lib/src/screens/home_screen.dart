import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/providers/home_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/utils/size_library.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SizeLibrary sizeLibrary = SizeLibrary(context);
    final settingsState = ref.watch(settingsProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: sizeLibrary.appSize(12),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: sizeLibrary.appWidth(context, 60),
                              child: Text(
                                settingsState.isFetchingLocation
                                    ? S.of(context).locationIntroBtnLoading
                                    : settingsState.address.address,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: sizeLibrary.appSize(12),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      child: Icon(
                        Icons.settings,
                        size: sizeLibrary.appSize(24),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onTap: () => context.pushNamed('settings'),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeLibrary.appSize(200),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          homeState.currentPrayer?.name.english ??
                              S.of(context).loading,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: sizeLibrary.appSize(34),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              homeState.currentPrayer?.name.arabic ?? "",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: sizeLibrary.appSize(18),
                                fontFamily: "Lateef",
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
                        InkWell(
                          onTap: () {
                            ref.read(homeProvider.notifier).changeToPrevDate();
                          },
                          child: Icon(
                            Icons.arrow_left_rounded,
                            size: sizeLibrary.appSize(40),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ref.read(homeProvider.notifier).changeToToday();
                            },
                            child: Text(
                              DateFormat('EEE dd MMM, yyyy')
                                  .format(homeState.dateTime)
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: sizeLibrary.appSize(12),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref.read(homeProvider.notifier).changeToNextDate();
                          },
                          child: Icon(
                            Icons.arrow_right_rounded,
                            size: sizeLibrary.appSize(40),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(sizeLibrary.appSize(12)),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final PrayerTime prayer = homeState.prayers[index];
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    prayer.name.english,
                                    style: TextStyle(
                                      fontSize: sizeLibrary.appSize(12),
                                      fontWeight: prayer.isCurrentPrayer
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    DateFormat('hh:mm a')
                                        .format(prayer.startTime),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: sizeLibrary.appSize(16),
                                      fontWeight: prayer.isCurrentPrayer
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    prayer.name.arabic,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: sizeLibrary.appSize(16),
                                      fontFamily: "Lateef",
                                      fontWeight: prayer.isCurrentPrayer
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 12);
                          },
                          itemCount: homeState.prayers.length,
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
