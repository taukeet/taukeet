import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/src/providers/home_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';

class HomeScreenNew extends ConsumerWidget {
  const HomeScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
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
                            color: Colors.white.withOpacity(0.8),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              settingsState.isFetchingLocation
                                  ? S.of(context)!.locationIntroBtnLoading
                                  : settingsState.address.address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('hh:mm a').format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => context.pushNamed('settings'),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white.withOpacity(0.6),
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Date Selector
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    _buildDateTab(
                      DateFormat('dd MMM').format(
                          homeState.dateTime.subtract(const Duration(days: 1))),
                      false,
                      () => ref.read(homeProvider.notifier).changeToPrevDate(),
                    ),
                    _buildDateTab(
                      DateFormat('dd MMM yyyy').format(homeState.dateTime),
                      true,
                      () => ref.read(homeProvider.notifier).changeToToday(),
                    ),
                    _buildDateTab(
                      DateFormat('dd MMM').format(
                          homeState.dateTime.add(const Duration(days: 1))),
                      false,
                      () => ref.read(homeProvider.notifier).changeToNextDate(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Prayer Times Grid
              Expanded(
                child: homeState.prayers.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context)!.loading,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: homeState.prayers.length,
                        itemBuilder: (context, index) {
                          final prayer = homeState.prayers[index];
                          return _buildPrayerCard(
                            prayer.name.english,
                            DateFormat('hh:mm').format(prayer.startTime),
                            DateFormat('a').format(prayer.startTime),
                            _getIconForPrayer(prayer.name.english),
                            prayer.isCurrentPrayer
                                ? const Color(0xFF4A6CF7)
                                : const Color(0xFF2A2A2A),
                            isHighlighted: prayer.isCurrentPrayer,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTab(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4A6CF7) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
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
    String prayerName,
    String time,
    String period,
    IconData icon,
    Color backgroundColor, {
    bool isHighlighted = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? Border.all(color: Colors.white.withOpacity(0.1), width: 1)
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
              color: Colors.white.withOpacity(0.08),
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
                    color: Colors.white.withOpacity(0.8),
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
                      style: const TextStyle(
                        color: Colors.white,
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
                          color: Colors.white.withOpacity(0.8),
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
