import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/providers/locale_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/utils/extensions.dart';
import 'package:taukeet/src/widgets/primary_button.dart';
import 'package:taukeet/src/widgets/secondary_button.dart';
import 'package:taukeet/src/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/widgets/select_higher_latitude_dialog.dart';
import 'package:taukeet/src/widgets/select_locale_dialog.dart';
import 'package:taukeet/src/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';
import 'package:taukeet/src/widgets/warning_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final localeState = ref.watch(localeProvider);

    // Listen to settings changes for dialogs
    ref.listen(settingsProvider, (previous, next) {
      if (!next.isFetchingLocation && !next.isLocationEnabled) {
        showDialog(
          context: context,
          builder: (context) {
            return WarningDialog(
              title: S.of(context)!.disableLocationTitle,
              message: S.of(context)!.disableLocationMessage,
              actions: [
                SecondaryButton(
                  text: S.of(context)!.cancel,
                  onPressed: () => Navigator.pop(context),
                ),
                PrimaryButton(
                  text: S.of(context)!.openSettings,
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.location);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }

      if (!next.isFetchingLocation && !next.hasLocationPermission) {
        showDialog(
          context: context,
          builder: (context) {
            return WarningDialog(
              title: S.of(context)!.permissionErrorTitle,
              message: S.of(context)!.permissionErrorMessage,
              actions: [
                SecondaryButton(
                  text: S.of(context)!.cancel,
                  onPressed: () => Navigator.pop(context),
                ),
                PrimaryButton(
                  text: S.of(context)!.openSettings,
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.settings);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text(S.of(context)!.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SettingTile(
                text: settingsState.isFetchingLocation
                    ? S.of(context)!.locationIntroBtnLoading
                    : settingsState.address.address,
                secodaryText: settingsState.isFetchingLocation
                    ? null
                    : S.of(context)!.fetchLocationDesc,
                icon: Icons.location_pin,
                onPressed: () => ref
                    .read(settingsProvider.notifier)
                    .fetchLocation(localeState.locale.languageCode),
              ),
              SettingTile(
                text: S
                    .of(context)!
                    .parseL10n(settingsState.madhab.lowercaseFirstChar()),
                secodaryText: S.of(context)!.changeMadhabDesc,
                icon: Icons.domain,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SelectMadhabDialog(),
                  );
                },
              ),
              SettingTile(
                text: S.of(context)!.parseL10n(
                    settingsState.calculationMethod.lowercaseFirstChar()),
                secodaryText: S.of(context)!.changeCalculationMethodDesc,
                icon: Icons.timelapse,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SelectCalculationMethodDialog(),
                  );
                },
              ),
              SettingTile(
                text: S.of(context)!.parseL10n(
                    settingsState.higherLatitude.lowercaseFirstChar()),
                secodaryText: S.of(context)!.changeLattitudeSetting,
                icon: Icons.keyboard_double_arrow_up,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SelectHigherLatitudeDialog(),
                  );
                },
              ),
              SettingTile(
                text: S.of(context)!.prayerSdjustments,
                secodaryText: S.of(context)!.changeAdjustmentsDesc,
                icon: Icons.adjust,
                onPressed: () {
                  context.pushNamed('settings.adjustments');
                },
              ),
              SettingTile(
                text: S.of(context)!.changeLanguage,
                icon: Icons.translate,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SelectLocaleDialog(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
