import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/src/implementations/adhan_impl.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';

// Provider for prayer data (loaded in main.dart)
final prayerDataProvider = Provider<Map<String, dynamic>>((ref) {
  throw UnimplementedError('prayerDataProvider must be overridden in main.dart');
});

// Provider for PrayerTimeService
final prayerTimeProvider = Provider<PrayerTimeService>((ref) {
  final settings = ref.watch(settingsProvider);
  final prayerData = ref.watch(prayerDataProvider);
  final prayerService = AdhanImpl(data: prayerData); // Instantiate here

  prayerService.init(
    settings.address,
    settings.adjustments,
    settings.calculationMethod,
    settings.madhab,
    settings.higherLatitude,
  );

  return prayerService;
});

// Provider for prayer times
final prayerTimesProvider = Provider.family<List<PrayerTime>, DateTime>((ref, dateTime) {
  final prayerService = ref.watch(prayerTimeProvider);
  
  return prayerService.prayers(dateTime);
});

// Provider for current prayer
final currentPrayerProvider = Provider.family<PrayerTime?, DateTime>((ref, dateTime) {
  final prayerService = ref.watch(prayerTimeProvider);

  return prayerService.currentPrayer();
});