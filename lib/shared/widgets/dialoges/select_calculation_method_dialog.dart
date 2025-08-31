import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/core/utils/extensions.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/shared/widgets/setting_tile.dart';

class SelectCalculationMethodDialog extends ConsumerWidget {
  const SelectCalculationMethodDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodsAsync = ref.watch(calculationMethodsProvider);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: methodsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error loading methods'),
            ),
            data: (methods) => Column(
              mainAxisSize: MainAxisSize.min,
              children: methods.map((method) {
                return SettingTile(
                  text: context.parseL10n(method.lowercaseFirstChar()),
                  secodaryText:
                      context.parseL10n('${method.lowercaseFirstChar()}Desc'),
                  icon: Icons.arrow_right,
                  onPressed: () {
                    ref
                        .read(settingsProvider.notifier)
                        .updateCalculationMethod(method);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
