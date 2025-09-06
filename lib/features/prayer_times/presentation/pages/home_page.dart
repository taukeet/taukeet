import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/home_page_provider.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/app/app.dart';

import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/core/utils/extensions.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final homeState = ref.watch(homePageProvider);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
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
                            size: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              settingsState.isFetchingLocation
                                  ? S.of(context)!.locationIntroBtnLoading
                                  : settingsState.settings.address.address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('hh:mm a').format(DateTime.now()),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    _buildDateTab(
                      context,
                      DateFormat('dd MMM').format(
                          homeState.dateTime.subtract(const Duration(days: 1))),
                      false,
                      () => ref
                          .read(homePageProvider.notifier)
                          .changeToPrevDate(),
                    ),
                    _buildDateTab(
                      context,
                      DateFormat('dd MMM yyyy').format(homeState.dateTime),
                      true,
                      () => ref.read(homePageProvider.notifier).changeToToday(),
                    ),
                    _buildDateTab(
                      context,
                      DateFormat('dd MMM').format(
                          homeState.dateTime.add(const Duration(days: 1))),
                      false,
                      () => ref
                          .read(homePageProvider.notifier)
                          .changeToNextDate(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              homeState.prayers.when(
                data: (prayers) {
                  if (prayers.isEmpty) {
                    return Center(
                      child: Text(
                        S.of(context)!.loading, // or "No prayers found"
                        style: TextStyle(
                          color: colorScheme.onSurface.withValues(alpha: 0.8),
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: prayers.length,
                    shrinkWrap: true, // Added this
                    physics: const NeverScrollableScrollPhysics(), // Added this
                    itemBuilder: (context, index) {
                      final prayer = prayers[index];
                      return _buildPrayerCard(
                        context,
                        S.of(context)!.parseL10n(
                              prayer.name.english.lowercaseFirstChar(),
                            ),
                        DateFormat('hh:mm').format(prayer.startTime),
                        DateFormat('a').format(prayer.startTime),
                        _getIconForPrayer(prayer.name.english),
                        prayer.isCurrentPrayer
                            ? AppColors.primary
                            : colorScheme.surface,
                        isHighlighted: prayer.isCurrentPrayer,
                      );
                    },
                  );
                },
                loading: () => Center(
                  child: Text(
                    S.of(context)!.loading,
                    style: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                      fontSize: 18,
                    ),
                  ),
                ),
                error: (err, stack) => Center(
                  child: Text(
                    'Error: $err',
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              )

              // Prayer Times Grid
              // Expanded(
              //   child: homeState.prayers.isEmpty
              //       ? Center(
              //           child: Text(
              //             S.of(context)!.loading,
              //             style: TextStyle(
              //               color: colorScheme.onSurface.withValues(alpha: 0.8),
              //               fontSize: 18,
              //             ),
              //           ),
              //         )
              //       : GridView.builder(
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //             crossAxisSpacing: 15,
              //             mainAxisSpacing: 15,
              //             childAspectRatio: 1.1,
              //           ),
              //           itemCount: homeState.prayers.length,
              //           itemBuilder: (context, index) {
              //             final prayer = homeState.prayers[index];
              //             return _buildPrayerCard(
              //               context,
              //               S.of(context)!.parseL10n(
              //                   prayer.name.english.lowercaseFirstChar()),
              //               DateFormat('hh:mm').format(prayer.startTime),
              //               DateFormat('a').format(prayer.startTime),
              //               _getIconForPrayer(prayer.name.english),
              //               prayer.isCurrentPrayer
              //                   ? AppColors.primary
              //                   : colorScheme.surface,
              //               isHighlighted: prayer.isCurrentPrayer,
              //             );
              //           },
              //         ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTab(
      BuildContext context, String text, bool isSelected, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForPrayer(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return Icons.brightness_2;
      case 'sunrise':
        return Icons.wb_sunny;
      case 'dhuhr':
        return Icons.wb_sunny;
      case 'asr':
        return Icons.account_balance;
      case 'maghrib':
        return Icons.brightness_2;
      case 'isha':
        return Icons.star;
      default:
        return Icons.access_time;
    }
  }

  Widget _buildPrayerCard(
    BuildContext context,
    String prayerName,
    String time,
    String period,
    IconData icon,
    Color backgroundColor, {
    bool isHighlighted = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? Border.all(
                color: colorScheme.onSurface.withValues(alpha: 0.1), width: 1)
            : null,
      ),
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Icon
          Positioned(
            bottom: 5,
            right: 5,
            child: Icon(
              icon,
              color: colorScheme.onSurface.withValues(alpha: 0.08),
              size: 70,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        period,
                        style: TextStyle(
                          color: colorScheme.onSurface.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
