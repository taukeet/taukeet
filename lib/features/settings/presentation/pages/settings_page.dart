import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/core/utils/extensions.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';
import 'package:taukeet/shared/widgets/dialoges/select_calculation_method_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/select_higher_latitude_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/select_locale_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/select_madhab_dialog.dart';
import 'package:taukeet/shared/widgets/setting_tile.dart';
import 'package:taukeet/shared/widgets/dialoges/warning_dialog.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);

    // Watch the async settings
    final settingsAsync = ref.watch(settingsFutureProvider);

    return settingsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error loading settings')),
      ),
      data: (_) {
        // Listen to locale changes for address translation
        ref.listen(localeProvider, (previous, next) {
          if (previous != null && previous.locale != next.locale) {
            ref
                .read(settingsProvider.notifier)
                .translateAddress(next.locale.languageCode);
          }
        });

        // Listen to settings state changes for location dialogs
        final settingsState = ref.watch(settingsProvider);
        final settings = settingsState.settings;

        ref.listen<SettingsState>(settingsProvider, (previous, next) {
          if (!next.isFetchingLocation && !next.isLocationEnabled) {
            _showWarningDialog(
              context,
              title: S.of(context)!.disableLocationTitle,
              message: S.of(context)!.disableLocationMessage,
              openType: AppSettingsType.location,
            );
          } else if (!next.isFetchingLocation && !next.hasLocationPermission) {
            _showWarningDialog(
              context,
              title: S.of(context)!.permissionErrorTitle,
              message: S.of(context)!.permissionErrorMessage,
              openType: AppSettingsType.settings,
            );
          }
        });

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            elevation: 1,
            title: Text(
              S.of(context)!.settings,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                SettingTile(
                  text: settingsState.isFetchingLocation
                      ? S.of(context)!.locationIntroBtnLoading
                      : settings.address.address,
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
                      .parseL10n(settings.madhab.lowercaseFirstChar()),
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
                      settings.calculationMethod.lowercaseFirstChar()),
                  secodaryText: S.of(context)!.changeCalculationMethodDesc,
                  icon: Icons.timelapse,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const SelectCalculationMethodDialog(),
                    );
                  },
                ),
                SettingTile(
                  text: S
                      .of(context)!
                      .parseL10n(settings.higherLatitude.lowercaseFirstChar()),
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
        );
      },
    );
  }

  void _showWarningDialog(
    BuildContext context, {
    required String title,
    required String message,
    required AppSettingsType openType,
  }) {
    showDialog(
      context: context,
      builder: (context) => WarningDialog(
        title: title,
        message: message,
        actions: [
          SecondaryButton(
            text: S.of(context)!.cancel,
            onPressed: () => Navigator.pop(context),
          ),
          PrimaryButton(
            text: S.of(context)!.openSettings,
            onPressed: () {
              AppSettings.openAppSettings(type: openType);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
