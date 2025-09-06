// splash_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';

class SplashPage extends ConsumerStatefulWidget {
  final Duration splashDelay;
  final VoidCallback? onNavigationComplete; // For testing callbacks

  const SplashPage({
    super.key,
    this.splashDelay = const Duration(seconds: 1),
    this.onNavigationComplete,
  });

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _hasNavigated = false;

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsFutureProvider);

    ref.listen(settingsFutureProvider, (previous, next) {
      if (_hasNavigated) return; // Prevent multiple navigations

      next.whenOrNull(
        data: (settings) => _handleSettingsLoaded(context, settings),
      );
    });

    return settingsAsync.when(
      data: (_) => _buildSplash(context),
      loading: () => _buildLoading(),
      error: (error, stack) => _buildError(error),
    );
  }

  void _handleSettingsLoaded(BuildContext context, dynamic settings) {
    Future.delayed(widget.splashDelay, () {
      if (!mounted || _hasNavigated) return;

      _hasNavigated = true;
      _navigateBasedOnSettings(context, settings);
      widget.onNavigationComplete?.call();
    });
  }

  void _navigateBasedOnSettings(BuildContext context, dynamic settings) {
    if (!context.mounted) return;

    final route = settings.isTutorialCompleted ? 'home' : 'intro';
    context.replaceNamed(route);
  }

  Widget _buildSplash(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
          child: _buildSplashContent(context),
        ),
      ),
    );
  }

  Widget _buildSplashContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/icon.png',
          height: 60,
          key: const Key('splash_icon'),
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context)!.appTitle,
          style: const TextStyle(
            fontSize: 36,
            fontFamily: 'Lateef',
          ),
          key: const Key('splash_title'),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          key: Key('splash_loading'),
        ),
      ),
    );
  }

  Widget _buildError(Object error) {
    return Scaffold(
      body: Center(
        child: Text(
          'Error loading settings: $error',
          key: const Key('splash_error'),
        ),
      ),
    );
  }
}
