import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:taukeet/shared/l10n/locale_helper.dart';

class SelectLocaleDialog extends ConsumerWidget {
  const SelectLocaleDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);
    final currentLocale = localeState.locale;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: AppColors.background,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
          child: Column(
            children: localeState.supportedLocales.map((locale) {
              final isSelected =
                  locale.languageCode == currentLocale.languageCode;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Material(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: ListTile(
                    title: Text(
                      '${locale.fullName ?? 'Unknown'} ${locale.nativeName != null ? "(${locale.nativeName})" : ""}',
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      ref.read(localeProvider.notifier).setLocale(locale);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
