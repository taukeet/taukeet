import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/providers/splash_provider.dart';
import 'package:taukeet/src/utils/extensions.dart';
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

    // Listen for location/permission dialogs
    ref.listen(settingsProvider, (previous, next) {
      if (!next.isFetchingLocation && !next.isLocationEnabled) {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(
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
          ),
        );
      }
      if (!next.isFetchingLocation && !next.hasLocationPermission) {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(
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
          ),
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
              title: address.isEmpty ? S.of(context)!.locationText : address,
              description: address.isEmpty
                  ? S.of(context)!.locationIntro
                  : S.of(context)!.locationIntroNext,
              buttonText: isFetchingLocation
                  ? S.of(context)!.locationIntroBtnLoading
                  : S.of(context)!.locationIntroBtn,
              onPressed: isFetchingLocation
                  ? null
                  : () async {
                      final success = await ref
                          .read(introProvider.notifier)
                          .fetchLocation();
                      if (!context.mounted) return;
                      if (!success && !isFetchingLocation) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text(S.of(context)!.locationFetchNetworkFail),
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.grey[850],
                          ),
                        );
                      }
                    },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final madhab = ref.watch(
              settingsProvider.select((state) => state.madhab),
            );
            return SplashContainer(
              title: S.of(context)!.parseL10n(madhab.lowercaseFirstChar()),
              description: S.of(context)!.madhabIntro,
              buttonText: S.of(context)!.madhabIntroBtn,
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
              description: S.of(context)!.calculationMethodIntro,
              buttonText: S.of(context)!.calculationMethodBtn,
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
      backgroundColorAllTabs: const Color(0xFF1A1A1A),
      onDonePress: () {
        ref.read(settingsProvider.notifier).completeTutorial();
        context.replaceNamed('home');
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
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
