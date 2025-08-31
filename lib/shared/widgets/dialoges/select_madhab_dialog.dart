import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/app/app.dart';
import 'package:taukeet/shared/widgets/setting_tile.dart';

class SelectMadhabDialog extends ConsumerWidget {
  const SelectMadhabDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingTile(
              text: S.of(context)!.hanafi,
              secodaryText: S.of(context)!.hanafiDesc,
              icon: Icons.arrow_right,
              onPressed: () {
                ref
                    .read(settingsProvider.notifier)
                    .updateMadhab(Madhab.hanafi.name);
                Navigator.pop(context);
              },
            ),
            SettingTile(
              text: S.of(context)!.shafi,
              secodaryText: S.of(context)!.shafiDesc,
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
