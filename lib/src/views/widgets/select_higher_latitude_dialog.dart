import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/libraries/prayer_time_library.dart';
import 'package:taukeet/src/views/widgets/setting_tile.dart';

class SelectHigherLatitudeDialog extends StatelessWidget {
  const SelectHigherLatitudeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: getIt<PrayerTimeLibrary>().higherLatitudes.map(
              (e) {
                return SettingTile(
                  text: '${e["name"]}'.humanReadable(),
                  secodaryText:
                      e["description"] == null ? null : '${e["description"]}',
                  icon: Icons.arrow_right,
                  onPressed: () {
                    BlocProvider.of<SettingsCubit>(context)
                        .updateHigherLatitude(e["name"]!);
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
