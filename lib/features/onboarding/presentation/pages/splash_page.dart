import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/src/providers/settings_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => opacity = 1.0);
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        final settings = ref.read(settingsFutureProvider).value!;
        if (settings.isTutorialCompleted) {
          context.replaceNamed('home');
        } else {
          context.replaceNamed('intro');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsFutureProvider);

    return settingsAsync.when(
      data: (settings) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/icon.png',
                  height: 60,
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context)!.appTitle,
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Lateef',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error loading settings: $error')),
      ),
    );
  }
}
