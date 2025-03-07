import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';

class SelectHigherLatitudeDialog extends ConsumerWidget {
  const SelectHigherLatitudeDialog({super.key});

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
            children: getIt<PrayerTimeService>().higherLatitudes.map(
              (e) {
                return SettingTile(
                  text: '${e["name"]}'.humanReadable(),
                  secodaryText:
                      e["description"] == null ? null : '${e["description"]}',
                  icon: Icons.arrow_right,
                  onPressed: () {
                    ref
                        .read(settingsProvider.notifier)
                        .updateHigherLatitude(e["name"]!);

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
