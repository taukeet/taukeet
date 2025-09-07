import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';
import 'package:taukeet/shared/widgets/dialoges/warning_dialog.dart';
import 'package:taukeet/features/qiblah/presentation/providers/qiblah_provider.dart';

class QiblahPage extends ConsumerWidget {
  const QiblahPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiblahState = ref.watch(qiblahProvider);
    final qiblahNotifier = ref.read(qiblahProvider.notifier);
    final localeState = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.qiblah),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              qiblahState.address?.address ?? 'Location not set',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '${qiblahState.address!.latitude.toStringAsFixed(4)}, ${qiblahState.address!.longitude.toStringAsFixed(4)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              onPressed: qiblahState.isFetchingLocation
                  ? null
                  : () async {
                      final success = await qiblahNotifier
                          .fetchLocation(localeState.locale.languageCode);
                      if (!context.mounted) return;
                      if (!success) {
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
                              content:
                                  Text(S.of(context)!.locationFetchNetworkFail),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.grey[850],
                            ),
                          );
                        }
                      }
                    },
              text: qiblahState.isFetchingLocation
                  ? S.of(context)!.locationIntroBtnLoading
                  : S.of(context)!.locationIntroBtn,
            ),
            const SizedBox(height: 30),
            Text(
              'Qiblah Direction will be displayed here',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[800],
              child: const Center(
                child: Icon(
                  Icons.navigation,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
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
