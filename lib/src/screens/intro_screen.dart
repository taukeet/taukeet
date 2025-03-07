import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/providers/splash_provider.dart';
import 'package:taukeet/src/widgets/primary_button.dart';
import 'package:taukeet/src/widgets/secondary_button.dart';
import 'package:taukeet/src/widgets/select_calculation_method_dialog.dart';
import 'package:taukeet/src/widgets/select_madhab_dialog.dart';
import 'package:taukeet/src/widgets/warning_dialog.dart';

class IntroScreen extends ConsumerWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introState = ref.watch(introProvider);

    // Listen to settings changes for location/permission dialogs
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

    return IntroSlider(
      key: UniqueKey(),
      isShowPrevBtn: true,
      isShowSkipBtn: false,
      isShowNextBtn: introState.showNextButton,
      isShowDoneBtn: introState.showNextButton,
      listCustomTabs: [
        Consumer(
          builder: (context, ref, child) {
            final isFetchingLocation = ref.watch(
              settingsProvider.select((state) => state.isFetchingLocation),
            );
            final address = ref.watch(
              settingsProvider.select((state) => state.address.address),
            );
            return SplashContainer(
              icon: Icons.location_on,
              title: address.isEmpty ? "Location" : address,
              description: address.isEmpty
                  ? "Taukeet's accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results."
                  : "Thank you for the location, click on \"Next\" to continue",
              buttonText:
                  isFetchingLocation ? "Fetching location" : "Fetch location",
              onPressed: isFetchingLocation
                  ? null
                  : () async {
                      final success = await ref
                          .read(introProvider.notifier)
                          .fetchLocation();
                      if (!success && !isFetchingLocation) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Failed to fetch location. Please check your network and try again.",
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final madhabStr = ref.watch(
              settingsProvider.select((state) => state.madhabStr),
            );
            return SplashContainer(
              title: madhabStr.capitalized(),
              description:
                  "You can choose between Hanafi or Standard (Maliki, Shafi'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object's shadow is twice its length.",
              buttonText: "Change madhab",
              icon: Icons.people,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SelectMadhabDialog(),
                );
              },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final calculationMethod = ref.watch(
              settingsProvider.select((state) => state.calculationMethod),
            );
            return SplashContainer(
              title: calculationMethod.humanReadable(),
              description:
                  "The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.",
              buttonText: "Change calculation method",
              icon: Icons.people,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SelectCalculationMethodDialog(),
                );
              },
            );
          },
        ),
      ],
      backgroundColorAllTabs: Theme.of(context).colorScheme.secondary,
      onDonePress: () {
        ref.read(settingsProvider.notifier).completeTutorial();
        // context.pushReplacementNamed('home');
      },
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
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
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