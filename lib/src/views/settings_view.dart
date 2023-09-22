import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/location/location_cubit.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/views/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/views/widgets/select_higher_latitude_dialog.dart';
import 'package:taukeet/src/views/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/views/widgets/setting_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<SettingsCubit>(context),
        ),
        BlocProvider(
          create: (context) => LocationCubit(
            settingsCubit: BlocProvider.of<SettingsCubit>(context),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) => SettingTile(
                  text: state.isFetchingLocation
                      ? "Fetching your location..."
                      : state.address.address,
                  secodaryText: state.isFetchingLocation
                      ? null
                      : "tap to get the current location",
                  icon: Icons.location_pin,
                  onPressed: () =>
                      BlocProvider.of<LocationCubit>(context).fetchLocation(),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return SettingTile(
                    text: state.madhab.capitalized(),
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
            ],
          ),
        ),
      ),
    );
  }
}
