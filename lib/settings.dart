import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:taukeet/contracts/location_service.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/cubit/settings_cubit.dart';
import 'package:taukeet/service_locator.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        prayerService: getIt<PrayerService>(),
        locationService: getIt<LocationService>(),
        storageService: getIt<StorageService>(),
      )..initialize(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Color(0xffF0E7D8),
            ),
          ),
          backgroundColor: const Color(0xff191923),
          iconTheme: const IconThemeData(
            color: Color(0xffF0E7D8),
          ),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return SettingsList(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: const Color(0xffF0E7D8),
              sections: [
                SettingsSection(
                  titleTextStyle: const TextStyle(
                    color: Color(0xff191923),
                    fontWeight: FontWeight.w900,
                  ),
                  title: 'General',
                  tiles: [
                    SettingsTile(
                      title: 'Location',
                      leading: const Icon(Icons.location_on),
                      subtitle: state.isAddressFetching
                          ? "Fetching Address..."
                          : state.address,
                      onPressed: state.isAddressFetching
                          ? null
                          : (BuildContext context) {
                              BlocProvider.of<SettingsCubit>(context)
                                  .locateUser();
                            },
                    ),
                    SettingsTile(
                      title: 'Madhab',
                      leading: const Icon(Icons.lock_clock),
                      subtitle: state.madhab,
                      onPressed: (BuildContext context) {
                        showMadhabDialog(context);
                      },
                    ),
                    SettingsTile(
                      title: 'Calculation Method',
                      leading: const Icon(Icons.calculate),
                      subtitle: state.calculationMethod.replaceAll("_", " "),
                      onPressed: (BuildContext context) {
                        showCalculationDialog(
                            context, state.calculationMethods);
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  showMadhabDialog(BuildContext context) {
    // set up the list options
    Widget hanfi = SimpleDialogOption(
      child: const Text(
        'Hanfi',
        style: TextStyle(
          color: Color(0xffF0E7D8),
        ),
      ),
      onPressed: () {
        BlocProvider.of<SettingsCubit>(context).changeMadhab('hanfi');
        Navigator.of(context).pop();
      },
    );
    Widget others = SimpleDialogOption(
      child: const Text(
        'Others',
        style: TextStyle(
          color: Color(0xffF0E7D8),
        ),
      ),
      onPressed: () {
        BlocProvider.of<SettingsCubit>(context).changeMadhab('other');
        Navigator.of(context).pop();
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text(
        'Choose Madhab',
        style: TextStyle(
          color: Color(0xffF0E7D8),
        ),
      ),
      backgroundColor: const Color(0xff191923),
      children: <Widget>[
        hanfi,
        others,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

showCalculationDialog(
    BuildContext context, List<CalculationMethod> calculationMethods) {
  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text(
      'Choose Calculation Method',
      style: TextStyle(
        color: Color(0xffF0E7D8),
      ),
    ),
    backgroundColor: const Color(0xff191923),
    children: calculationMethods
        .map((CalculationMethod method) => SimpleDialogOption(
              child: Text(
                method.name.replaceAll("_", " "),
                style: const TextStyle(
                  color: Color(0xffF0E7D8),
                ),
              ),
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context)
                    .changeCalculationMethod(method.name);
                Navigator.of(context).pop();
              },
            ))
        .toList(),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
