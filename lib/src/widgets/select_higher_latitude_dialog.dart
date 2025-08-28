import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/utils/extensions.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';

class SelectHigherLatitudeDialog extends ConsumerWidget {
  const SelectHigherLatitudeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerService = ref.watch(prayerTimeProvider);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: prayerService.higherLatitudes.map(
              (String e) {
                return SettingTile(
                  text: S.of(context)!.parseL10n(e.lowercaseFirstChar()),
                  secodaryText:
                      S.of(context)!.parseL10n('${e.lowercaseFirstChar()}Desc'),
                  icon: Icons.arrow_right,
                  onPressed: () {
                    ref.read(settingsProvider.notifier).updateHigherLatitude(e);
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
