import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';
import 'package:taukeet/src/providers/settings_provider.dart';

// Provider for prayer data (loaded in main.dart)
final prayerDataProvider = Provider<Map<String, dynamic>>((ref) {
  throw UnimplementedError(
      'prayerDataProvider must be overridden in main.dart');
});

// Provider for prayer times use case
final getPrayerTimesUseCaseProvider = Provider<GetPrayerTimes>((ref) {
  throw UnimplementedError(
      'getPrayerTimesUseCaseProvider must be overridden with dependency injection');
});

// Provider for current prayer use case
final getCurrentPrayerUseCaseProvider = Provider<GetCurrentPrayer>((ref) {
  throw UnimplementedError(
      'getCurrentPrayerUseCaseProvider must be overridden with dependency injection');
});

// Provider for prayer times
final prayerTimesProvider =
    FutureProvider.family<List<PrayerTime>, DateTime>((ref, dateTime) async {
  final useCase = ref.watch(getPrayerTimesUseCaseProvider);
  final settings = ref.watch(settingsProvider);

  final params = GetPrayerTimesParams(
    date: dateTime,
    location: settings.address,
    adjustments: settings.adjustments,
    calculationMethod: settings.calculationMethod,
    madhab: settings.madhab,
    higherLatitude: settings.higherLatitude,
  );

  final result = await useCase(params);

  return result.fold(
    (failure) => <PrayerTime>[], // Return empty list on failure
    (prayers) => prayers,
  );
});

// Provider for current prayer
final currentPrayerProvider =
    FutureProvider.family<PrayerTime?, DateTime>((ref, dateTime) async {
  final useCase = ref.watch(getCurrentPrayerUseCaseProvider);
  final settings = ref.watch(settingsProvider);

  final params = GetCurrentPrayerParams(
    location: settings.address,
    adjustments: settings.adjustments,
    calculationMethod: settings.calculationMethod,
    madhab: settings.madhab,
    higherLatitude: settings.higherLatitude,
  );

  final result = await useCase(params);

  return result.fold(
    (failure) => null, // Return null on failure
    (prayer) => prayer,
  );
});
