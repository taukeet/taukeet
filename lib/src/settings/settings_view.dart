import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingTile(
              text: "Location",
              secodaryText: "tap to get the current location",
              icon: Icons.location_pin,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.text,
    required this.icon,
    this.secodaryText,
    this.onPressed,
  });

  final String text;
  final IconData icon;
  final String? secodaryText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 4.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    ...[
                      secodaryText != null
                          ? Text(
                              secodaryText!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.6),
                              ),
                            )
                          : Container()
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
