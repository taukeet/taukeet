import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/locale_provider.dart';
import 'package:taukeet/src/utils/locale_helper.dart';

class SelectLocaleDialog extends ConsumerWidget {
  const SelectLocaleDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: localeState.supportedLocales
                .map((locale) => Text(
                      locale.fullName ?? 'Unknown Locale',
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
