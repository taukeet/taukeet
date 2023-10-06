import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:go_router/go_router.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/blocs/splash/splash_cubit.dart';
import 'package:taukeet/src/views/widgets/primary_button.dart';
import 'package:taukeet/src/views/widgets/secondary_button.dart';
import 'package:taukeet/src/views/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/views/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/views/widgets/warning_dialog.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return IntroSlider(
              key: UniqueKey(),
              isShowPrevBtn: true,
              isShowSkipBtn: false,
              isShowNextBtn: state.showNextButton,
              isShowDoneBtn: state.showNextButton,
              listCustomTabs: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return SplashContainer(
                      icon: Icons.location_on,
                      title: state.address.address.isEmpty
                          ? "Location"
                          : state.address.address,
                      description: state.address.address.isEmpty
                          ? "Taukeet's accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results."
                          : "Thank you for the location, click on \"Next\" to continue",
                      buttonText: state.isFetchingLocation
                          ? "Fetching location"
                          : "Fetch location",
                      onPressed: state.isFetchingLocation
                          ? null
                          : () {
                              BlocProvider.of<SplashCubit>(context)
                                  .fetchLocation();
                            },
                    );
                  },
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return SplashContainer(
                      title: state.madhabStr.capitalize(),
                      description:
                          "You can choose between Hanafi or Standard (Maliki, Shafi'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object's shadow is twice its length.",
                      buttonText: "Change madhab",
                      icon: Icons.people,
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
                    return SplashContainer(
                      title: state.calculationMethod.humanReadable(),
                      description:
                          "The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.",
                      buttonText: "Change calculation method",
                      icon: Icons.people,
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
              backgroundColorAllTabs: Theme.of(context).colorScheme.secondary,
              onDonePress: () {
                BlocProvider.of<SettingsCubit>(context).completeTutorial();
                context.pushReplacementNamed('home');
              },
            );
          },
        ),
      ),
    );
  }
}

class SplashContainer extends StatelessWidget {
  const SplashContainer({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              text: buttonText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
