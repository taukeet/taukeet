import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/views/widgets/primary_button.dart';
import 'package:taukeet/src/views/widgets/text_form_input.dart';

class AdjustmentsView extends StatelessWidget {
  const AdjustmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

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
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              Adjustments adjustments = state.adjustments;

              return FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormInput(
                      name: "fajr",
                      label: "Fajr",
                      initialValue: adjustments.fajr.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormInput(
                      name: "sunrise",
                      label: "Sunrise",
                      initialValue: adjustments.sunrise.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormInput(
                      name: "dhuhr",
                      label: "Dhuhr",
                      initialValue: adjustments.dhuhr.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormInput(
                      name: "asr",
                      label: "Asr",
                      initialValue: adjustments.asr.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormInput(
                      name: "maghrib",
                      label: "Maghrib",
                      initialValue: adjustments.maghrib.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormInput(
                      name: "isha",
                      label: "Isha",
                      initialValue: adjustments.isha.toString(),
                      textInputType: TextInputType.number,
                      required: true,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    PrimaryButton(
                      text: "Save Adjustments",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final fields = formKey.currentState?.fields;
                          BlocProvider.of<SettingsCubit>(context)
                              .updateAdjustments(
                            fajr: int.parse(fields?['fajr']!.value ?? 0),
                            sunrise: int.parse(fields?['sunrise']!.value ?? 0),
                            dhuhr: int.parse(fields?['dhuhr']!.value ?? 0),
                            asr: int.parse(fields?['asr']!.value ?? 0),
                            maghrib: int.parse(fields?['maghrib']!.value ?? 0),
                            isha: int.parse(fields?['isha']!.value ?? 0),
                          );

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Adjustments saved successfully"),
                          ));

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
