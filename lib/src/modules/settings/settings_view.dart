import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/libraries/prayer_time_library.dart';
import 'package:taukeet/src/modules/settings/cubit/location_cubit.dart';
import 'package:taukeet/src/modules/settings/cubit/settings_cubit.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}

class SelectMadhabDialog extends StatelessWidget {
  const SelectMadhabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingTile(
              text: Madhab.Hanafi.capitalized(),
              secodaryText: "Later Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context)
                    .updateMadhab(Madhab.Hanafi);
                Navigator.pop(context);
              },
            ),
            SettingTile(
              text: Madhab.Shafi.capitalized(),
              secodaryText: "Earlier Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context)
                    .updateMadhab(Madhab.Shafi);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCalculationMethodDialog extends StatelessWidget {
  const SelectCalculationMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: PrayerTimeLibrary.calculationMethods.map(
              (e) {
                return SettingTile(
                  text: '${e["name"]}'.humanReadable(),
                  secodaryText: '${e["description"]}',
                  icon: Icons.arrow_right,
                  onPressed: () {
                    BlocProvider.of<SettingsCubit>(context)
                        .updateCalculationMethod(e["name"]!);
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

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.text,
    required this.icon,
    this.secodaryText,
    this.onPressed,
  });

  final String text;
  final IconData icon;
  final String? secodaryText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 4.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      ...[
                        secodaryText != null
                            ? Text(
                                secodaryText!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(.6),
                                ),
                              )
                            : Container()
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
