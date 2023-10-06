import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/views/widgets/setting_tile.dart';

class SelectMadhabDialog extends StatelessWidget {
  const SelectMadhabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingTile(
              text: Madhab.hanafi.name.capitalized(),
              secodaryText: "Later Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context)
                    .updateMadhab(Madhab.hanafi.name);
                Navigator.pop(context);
              },
            ),
            SettingTile(
              text: "Standard",
              secodaryText: "Maliki, Shafi'i, Hanbali - Earlier Asr time",
              icon: Icons.arrow_right,
              onPressed: () {
                BlocProvider.of<SettingsCubit>(context)
                    .updateMadhab(Madhab.shafi.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
