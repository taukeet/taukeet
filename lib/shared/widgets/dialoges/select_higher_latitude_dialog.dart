import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/app/app.dart';
import 'package:taukeet/core/utils/extensions.dart';
import 'package:taukeet/shared/widgets/setting_tile.dart';

class SelectHigherLatitudeDialog extends ConsumerWidget {
  const SelectHigherLatitudeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final higherLatitudesAsync = ref.watch(higherLatitudesProvider);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: higherLatitudesAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(child: Text('Error loading options')),
          ),
          data: (latitudes) => SingleChildScrollView(
            child: Column(
              children: latitudes.map(
                (String e) {
                  return SettingTile(
                    text: S.of(context)!.parseL10n(e.lowercaseFirstChar()),
                    secodaryText: S
                        .of(context)!
                        .parseL10n('${e.lowercaseFirstChar()}Desc'),
                    icon: Icons.arrow_right,
                    onPressed: () {
                      ref
                          .read(settingsProvider.notifier)
                          .updateHigherLatitude(e);
                      Navigator.pop(context);
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
