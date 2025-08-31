import 'package:app_settings/app_settings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/generated/l10n.mapper.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/providers/splash_provider.dart';
import 'package:taukeet/core/utils/extensions.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';
import 'package:taukeet/shared/widgets/dialoges/select_calculation_method_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/select_locale_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/select_madhab_dialog.dart';
import 'package:taukeet/shared/widgets/dialoges/warning_dialog.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This listener is for dialogs and is independent of the main UI build.
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

    return Consumer(
      builder: (context, ref, _) {
        final introState = ref.watch(introProvider);

        final slides = [
          // Slide 1: Language selection
          Consumer(
            builder: (context, ref, child) {
              return SplashContainer(
                title: S.of(context)!.chooseLanguage,
                description: S.of(context)!.chooseLanguageDesc,
                buttonText: S.of(context)!.chooseLanguageBtn,
                icon: Icons.translate,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SelectLocaleDialog(),
                  );
                },
              );
            },
          ),

          // Slide 2: Location selection
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

          // Slide 3: Madhab selection
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

          // Slide 4: Calculation method selection
          Consumer(
            builder: (context, ref, child) {
              final calculationMethod = ref.watch(
                settingsProvider.select((state) => state.calculationMethod),
              );
              return SplashContainer(
                title: S
                    .of(context)!
                    .parseL10n(calculationMethod.lowercaseFirstChar()),
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
        ];

        return Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          body: Column(
            children: [
              // Carousel
              Expanded(
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                      // Update the intro provider with current slide
                      ref
                          .read(introProvider.notifier)
                          .updateCurrentSlide(index);
                    },
                  ),
                  items: slides,
                ),
              ),

              // Bottom navigation controls
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: slides.asMap().entries.map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Previous button
                        if (_currentIndex > 0)
                          SecondaryButton(
                            text: S.of(context)!.previous,
                            onPressed: () {
                              _carouselController.previousPage();
                            },
                          )
                        else
                          const SizedBox(
                              width: 80), // Placeholder for alignment

                        // Next/Done button
                        if (_currentIndex < slides.length - 1)
                          PrimaryButton(
                            text: S.of(context)!.next,
                            onPressed: introState.showNextButton
                                ? () {
                                    _carouselController.nextPage();
                                  }
                                : null,
                          )
                        else
                          PrimaryButton(
                            text: S.of(context)!.done,
                            onPressed: introState.showNextButton
                                ? () {
                                    ref
                                        .read(settingsProvider.notifier)
                                        .completeTutorial();
                                    context.replaceNamed('home');
                                  }
                                : null,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// The SplashContainer widget remains unchanged.
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
