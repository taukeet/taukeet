import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Prayer Adjustments"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 12.0,
          ),
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormInput(
                  name: "fajr",
                  label: "Fajr",
                  initialValue: settingsState.adjustments.fajr.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 14),
                TextFormInput(
                  name: "sunrise",
                  label: "Sunrise",
                  initialValue: settingsState.adjustments.sunrise.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 14),
                TextFormInput(
                  name: "dhuhr",
                  label: "Dhuhr",
                  initialValue: settingsState.adjustments.dhuhr.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 14),
                TextFormInput(
                  name: "asr",
                  label: "Asr",
                  initialValue: settingsState.adjustments.asr.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 14),
                TextFormInput(
                  name: "maghrib",
                  label: "Maghrib",
                  initialValue: settingsState.adjustments.maghrib.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 14),
                TextFormInput(
                  name: "isha",
                  label: "Isha",
                  initialValue: settingsState.adjustments.isha.toString(),
                  textInputType: TextInputType.number,
                  required: true,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SecondaryButton(
                      text: "Reset",
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
                          const SnackBar(
                            content: Text("Adjustments reset successfully"),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: "Save Adjustments",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final fields = formKey.currentState?.fields;
                          ref.read(settingsProvider.notifier).updateAdjustments(
                                fajr: int.parse(fields?['fajr']!.value ?? '0'),
                                sunrise:
                                    int.parse(fields?['sunrise']!.value ?? '0'),
                                dhuhr:
                                    int.parse(fields?['dhuhr']!.value ?? '0'),
                                asr: int.parse(fields?['asr']!.value ?? '0'),
                                maghrib:
                                    int.parse(fields?['maghrib']!.value ?? '0'),
                                isha: int.parse(fields?['isha']!.value ?? '0'),
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Adjustments saved successfully"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
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
