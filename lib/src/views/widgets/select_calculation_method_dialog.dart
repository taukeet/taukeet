import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/src/views/widgets/setting_tile.dart';

class SelectCalculationMethodDialog extends StatelessWidget {
  const SelectCalculationMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: getIt<PrayerTimeService>().calculationMethods.map(
              (e) {
                return SettingTile(
                  text: '${e["name"]}'.humanReadable(),
                  secodaryText: '${e["description"]}',
                  icon: Icons.arrow_right,
                  onPressed: () {
                    BlocProvider.of<SettingsCubit>(context)
                        .updateCalculationMethod(e["name"]!);
                    Navigator.pop(context);
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
