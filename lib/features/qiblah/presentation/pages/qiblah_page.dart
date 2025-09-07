import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';
import 'package:taukeet/shared/widgets/dialoges/warning_dialog.dart';
import 'package:taukeet/features/qiblah/presentation/providers/qiblah_provider.dart';
import 'package:taukeet/features/qiblah/presentation/widgets/qiblah_compass.dart';

class QiblahPage extends ConsumerWidget {
  const QiblahPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiblahState = ref.watch(qiblahProvider);
    final qiblahNotifier = ref.read(qiblahProvider.notifier);
    final localeState = ref.watch(localeProvider);

    final hasValidLocation = qiblahState.address?.latitude != null &&
        qiblahState.address?.longitude != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.qiblah),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Location info
              if (hasValidLocation) ...[
                Text(
                  qiblahState.address?.address ??
                      S.of(context)!.qiblahCurrentLocation,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context)!.qiblahLatLong(
                        qiblahState.address!.latitude.toStringAsFixed(4),
                        qiblahState.address!.longitude.toStringAsFixed(4),
                      ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
              ],

              // Location buttons
              if (!hasValidLocation) ...[
                Text(
                  S.of(context)!.qiblahLocationNotSet,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  onPressed: qiblahState.isFetchingLocation
                      ? null
                      : () async {
                          final success = await qiblahNotifier
                              .fetchLocation(localeState.locale.languageCode);
                          if (!context.mounted) return;
                          if (!success) {
                            _handleLocationError(context, qiblahState);
                          }
                        },
                  text: qiblahState.isFetchingLocation
                      ? S.of(context)!.locationIntroBtnLoading
                      : S.of(context)!.locationIntroBtn,
                ),
                const SizedBox(height: 12),
              ] else ...[
                SecondaryButton(
                  onPressed: qiblahState.isFetchingLocation
                      ? null
                      : () async {
                          final success = await qiblahNotifier
                              .fetchLocation(localeState.locale.languageCode);
                          if (!context.mounted) return;
                          if (!success) {
                            _handleLocationError(context, qiblahState);
                          }
                        },
                  text: qiblahState.isFetchingLocation
                      ? S.of(context)!.locationIntroBtnLoading
                      : S.of(context)!.qiblahUpdateLocation,
                ),
                const SizedBox(height: 10),
              ],

              // Compass or loader
              qiblahState.qiblahDirection != null
                  ? QiblahCompass(qiblahDirection: qiblahState.qiblahDirection!)
                  : hasValidLocation
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                S.of(context)!.qiblahCalculating,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      : Text(
                          S.of(context)!.qiblahDirectionHere,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLocationError(BuildContext context, dynamic qiblahState) {
    if (!qiblahState.hasLocationPermission) {
      _showWarningDialog(
        context,
        title: S.of(context)!.permissionErrorTitle,
        message: S.of(context)!.permissionErrorMessage,
        openType: AppSettingsType.settings,
      );
    } else if (!qiblahState.isLocationEnabled) {
      _showWarningDialog(
        context,
        title: S.of(context)!.disableLocationTitle,
        message: S.of(context)!.disableLocationMessage,
        openType: AppSettingsType.location,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)!.locationFetchNetworkFail),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.grey[850],
        ),
      );
    }
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
