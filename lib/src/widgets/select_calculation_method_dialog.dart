import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/core/utils/extensions.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';

class SelectCalculationMethodDialog extends ConsumerWidget {
  const SelectCalculationMethodDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerService = ref.watch(prayerTimeProvider);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: prayerService.calculationMethods.map(
              (String e) {
                return SettingTile(
                  text: context.parseL10n(e.lowercaseFirstChar()),
                  secodaryText:
                      context.parseL10n('${e.lowercaseFirstChar()}Desc'),
                  icon: Icons.arrow_right,
                  onPressed: () {
                    ref
                        .read(settingsProvider.notifier)
                        .updateCalculationMethod(e);
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
