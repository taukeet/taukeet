import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/views/widgets/primary_button.dart';
import 'package:taukeet/src/views/widgets/secondary_button.dart';
import 'package:taukeet/src/views/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/views/widgets/select_higher_latitude_dialog.dart';
import 'package:taukeet/src/views/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/views/widgets/setting_tile.dart';
import 'package:taukeet/src/views/widgets/warning_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<SettingsCubit>(context),
        ),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (!state.isFetchingLocation && !state.isLocationEnabled) {
            showDialog(
              context: context,
              builder: (context) {
                return WarningDialog(
                  title: "Warning",
                  message:
                      "Location is diabled, please enable to fetch the current location.",
                  actions: [
                    SecondaryButton(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: "Open Settings",
                      onPressed: () {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.location);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }

          if (!state.isFetchingLocation && !state.hasLocationPermission) {
            showDialog(
              context: context,
              builder: (context) {
                return WarningDialog(
                  title: "Permission Error",
                  message:
                      "Taukeet need location permission to fetch the current location, with current location taukeet calculate the prayer times.",
                  actions: [
                    SecondaryButton(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: "Open App Settings",
                      onPressed: () {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.settings);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) => SettingTile(
                    text: state.isFetchingLocation
                        ? "Fetching your location..."
                        : state.address.address,
                    secodaryText: state.isFetchingLocation
                        ? null
                        : "tap to get the current location",
                    icon: Icons.location_pin,
                    onPressed: () =>
                        BlocProvider.of<SettingsCubit>(context).fetchLocation(),
                  ),
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return SettingTile(
                      text: state.madhabStr.capitalized(),
                      secodaryText: "tap to change the madhab",
                      icon: Icons.domain,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const SelectMadhabDialog();
                          },
                        );
                      },
                    );
                  },
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return SettingTile(
                      text: state.calculationMethod.humanReadable(),
                      secodaryText: "tap to change the calculation method",
                      icon: Icons.timelapse,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const SelectCalculationMethodDialog();
                          },
                        );
                      },
                    );
                  },
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return SettingTile(
                      text: state.higherLatitude.humanReadable(),
                      secodaryText:
                          "In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to changed the method.",
                      icon: Icons.keyboard_double_arrow_up,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const SelectHigherLatitudeDialog();
                          },
                        );
                      },
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
        ),
      ),
    );
  }
}
