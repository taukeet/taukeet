import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/utils/extensions.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';

class SelectMadhabDialog extends ConsumerWidget {
  const SelectMadhabDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingTile(
              text: Madhab.hanafi.name.capitalized(),
              secodaryText: "Later Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                ref
                    .read(settingsProvider.notifier)
                    .updateMadhab(Madhab.hanafi.name);
                Navigator.pop(context);
              },
            ),
            SettingTile(
              text: "Standard",
              secodaryText: "Maliki, Shafi'i, Hanbali - Earlier Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                ref
                    .read(settingsProvider.notifier)
                    .updateMadhab(Madhab.shafi.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
