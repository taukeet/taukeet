import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:taukeet/contracts/location_service.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/cubit/settings_cubit.dart';
import 'package:taukeet/home.dart';
import 'package:taukeet/service_locator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final StorageService storageService = getIt<StorageService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        prayerService: getIt<PrayerService>(),
        locationService: getIt<LocationService>(),
        storageService: storageService,
      )..initialize(),
      child: IntroSlider(
        showSkipBtn: false,
        renderDoneBtn: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            const snackBar = SnackBar(
              content: Text('Please select the location'),
            );
            if (state.hasValidationError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar)
                  .closed
                  .then((_) {
                BlocProvider.of<SettingsCubit>(context)
                    .removeHasValidationError();
              });
            }
            if (state.isDataSaved) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isDataSaving) {
              return const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Color(0xffF0E7D8),
                  strokeWidth: 2,
                ),
              );
            }

            return TextButton(
              onPressed: () =>
                  BlocProvider.of<SettingsCubit>(context).saveSettingsData(),
              child: const Text(
                "DONE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        slides: [
          Slide(
            widgetDescription: Center(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xffF0E7D8),
                        size: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "We need your location to calculate the prayer times",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffF0E7D8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          if (state.isAddressFetching) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Color(0xffF0E7D8),
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          if (state.isAddressFetched) {
                            return Text(
                              state.address,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffF0E7D8),
                                fontSize: 14,
                              ),
                            );
                          }

                          return ElevatedButton(
                            onPressed: () =>
                                BlocProvider.of<SettingsCubit>(context)
                                    .locateUser(),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffF0E7D8),
                              shadowColor: const Color(0xffF0E7D8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Locate",
                              style: TextStyle(
                                color: Color(0xff191923),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
          Slide(
            widgetDescription: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_clock,
                    color: Color(0xffF0E7D8),
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please select the madhab, Asr time depends on it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF0E7D8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return DropdownButton(
                        hint: const Text("Select Madhab"),
                        dropdownColor: const Color(0xff191923),
                        style: const TextStyle(
                          color: Color(0xffF0E7D8),
                        ),
                        value: state.madhab,
                        items: const [
                          DropdownMenuItem(
                            child: Text("HANFI"),
                            value: "hanfi",
                          ),
                          DropdownMenuItem(
                            child: Text("OTHER"),
                            value: "other",
                          ),
                        ],
                        onChanged: (value) =>
                            BlocProvider.of<SettingsCubit>(context)
                                .changeMadhab(
                          value.toString(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
          Slide(
            widgetDescription: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calculate,
                    color: Color(0xffF0E7D8),
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please select the calulation method",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF0E7D8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return DropdownButton(
                        hint: const Text("Select Calculation Method"),
                        dropdownColor: const Color(0xff191923),
                        style: const TextStyle(
                          color: Color(0xffF0E7D8),
                        ),
                        value: state.calculationMethod,
                        items: state.calculationMethods
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(
                                  e.name.replaceAll("_", " ").toUpperCase(),
                                ),
                                value: e.name,
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            BlocProvider.of<SettingsCubit>(context)
                                .changeCalculationMethod(
                          value.toString(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
        ],
      ),
    );
  }
}
