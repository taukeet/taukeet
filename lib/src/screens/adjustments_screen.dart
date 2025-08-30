import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/widgets/primary_button.dart';
import 'package:taukeet/src/widgets/secondary_button.dart';
import 'package:taukeet/src/widgets/text_form_input.dart';

class AdjustmentsScreen extends ConsumerWidget {
  const AdjustmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A), // dark app bar
        title: Text(
          S.of(context)!.prayerSdjustments,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Fields
                ...[
                  {
                    'name': 'fajr',
                    'label': S.of(context)!.fajr,
                    'initial': settingsState.adjustments.fajr.toString(),
                  },
                  {
                    'name': 'sunrise',
                    'label': S.of(context)!.sunrise,
                    'initial': settingsState.adjustments.sunrise.toString(),
                  },
                  {
                    'name': 'dhuhr',
                    'label': S.of(context)!.dhuhr,
                    'initial': settingsState.adjustments.dhuhr.toString(),
                  },
                  {
                    'name': 'asr',
                    'label': S.of(context)!.asr,
                    'initial': settingsState.adjustments.asr.toString(),
                  },
                  {
                    'name': 'maghrib',
                    'label': S.of(context)!.maghrib,
                    'initial': settingsState.adjustments.maghrib.toString(),
                  },
                  {
                    'name': 'isha',
                    'label': S.of(context)!.isha,
                    'initial': settingsState.adjustments.isha.toString(),
                  },
                ].map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormInput(
                      name: e['name']!,
                      label: e['label']!,
                      initialValue: e['initial']!,
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                  );
                }),

                const SizedBox(height: 8),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        text: S.of(context)!.reset,
                        onPressed: () {
                          ref.read(settingsProvider.notifier).updateAdjustments(
                                fajr: 0,
                                sunrise: 0,
                                dhuhr: 0,
                                asr: 0,
                                maghrib: 0,
                                isha: 0,
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(S.of(context)!.adjustmentsResetSuccess),
                              backgroundColor: Colors.grey[850],
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        text: S.of(context)!.saveAdjustments,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final fields = formKey.currentState?.fields;
                            ref
                                .read(settingsProvider.notifier)
                                .updateAdjustments(
                                  fajr:
                                      int.parse(fields?['fajr']!.value ?? '0'),
                                  sunrise: int.parse(
                                      fields?['sunrise']!.value ?? '0'),
                                  dhuhr:
                                      int.parse(fields?['dhuhr']!.value ?? '0'),
                                  asr: int.parse(fields?['asr']!.value ?? '0'),
                                  maghrib: int.parse(
                                      fields?['maghrib']!.value ?? '0'),
                                  isha:
                                      int.parse(fields?['isha']!.value ?? '0'),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(S.of(context)!.adjustmentsSuccess),
                                backgroundColor: Colors.grey[850],
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
