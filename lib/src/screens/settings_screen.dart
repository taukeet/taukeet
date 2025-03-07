import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/widgets/primary_button.dart';
import 'package:taukeet/src/widgets/secondary_button.dart';
import 'package:taukeet/src/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/widgets/select_higher_latitude_dialog.dart';
import 'package:taukeet/src/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/widgets/setting_tile.dart';
import 'package:taukeet/src/widgets/warning_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);

    // Listen to settings changes for dialogs
    ref.listen(settingsProvider, (previous, next) {
      if (!next.isFetchingLocation && !next.isLocationEnabled) {
        showDialog(
          context: context,
          builder: (context) {
            return WarningDialog(
              title: "Warning",
              message:
                  "Location is disabled, please enable to fetch the current location.",
              actions: [
                SecondaryButton(
                  text: "Cancel",
                  onPressed: () => Navigator.pop(context),
                ),
                PrimaryButton(
                  text: "Open Settings",
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
              title: "Permission Error",
              message:
                  "Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.",
              actions: [
                SecondaryButton(
                  text: "Cancel",
                  onPressed: () => Navigator.pop(context),
                ),
                PrimaryButton(
                  text: "Open App Settings",
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
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingTile(
              text: settingsState.isFetchingLocation
                  ? "Fetching your location..."
                  : settingsState.address.address,
              secodaryText: settingsState.isFetchingLocation
                  ? null
                  : "tap to get the current location",
              icon: Icons.location_pin,
              onPressed: () =>
                  ref.read(settingsProvider.notifier).fetchLocation(),
            ),
            SettingTile(
              text: settingsState.madhabStr.capitalized(),
              secodaryText: "tap to change the madhab",
              icon: Icons.domain,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SelectMadhabDialog(),
                );
              },
            ),
            SettingTile(
              text: settingsState.calculationMethod.humanReadable(),
              secodaryText: "tap to change the calculation method",
              icon: Icons.timelapse,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SelectCalculationMethodDialog(),
                );
              },
            ),
            SettingTile(
              text: settingsState.higherLatitude.humanReadable(),
              secodaryText:
                  "In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.",
              icon: Icons.keyboard_double_arrow_up,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SelectHigherLatitudeDialog(),
                );
              },
            ),
            SettingTile(
              text: "Adjustments",
              secodaryText: "Adjust the prayer times by minutes",
              icon: Icons.adjust,
              onPressed: () {
                context.pushNamed('settings.adjustments');
              },
            ),
          ],
        ),
      ),
    );
  }
}
