import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';

class SelectCalculationMethodDialog extends ConsumerWidget {
  const SelectCalculationMethodDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: getIt<PrayerTimeService>().calculationMethods.map(
              (e) {
                return SettingTile(
                  text: '${e["name"]}'.humanReadable(),
                  secodaryText: '${e["description"]}',
                  icon: Icons.arrow_right,
                  onPressed: () {
                    ref
                        .read(settingsProvider.notifier)
                        .updateCalculationMethod(e["name"]!);
                    Navigator.pop(context);
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
