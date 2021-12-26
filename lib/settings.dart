import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SettingsList(
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
                subtitle: "Change your location",
                onPressed: (BuildContext context) {
                  print("herre");
                },
              ),
              SettingsTile(
                title: 'Madhab',
                leading: const Icon(Icons.lock_clock),
                subtitle: "Hanfi",
                onPressed: (BuildContext context) {
                  print("herre");
                },
              ),
              SettingsTile(
                title: 'Calculation Method',
                leading: const Icon(Icons.calculate),
                subtitle: "Hanfi",
                onPressed: (BuildContext context) {
                  print("herre");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
