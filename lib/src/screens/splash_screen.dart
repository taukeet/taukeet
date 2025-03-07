import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/src/providers/settings_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsFutureProvider);

    return settingsAsync.when(
      data: (settings) {
        // Navigate based on isTutorialCompleted
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (settings.isTutorialCompleted) {
            context.goNamed('home');
          } else {
            context.goNamed('intro');
          }
        });

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Error loading settings: $error'),
        ),
      ),
    );
  }
}
