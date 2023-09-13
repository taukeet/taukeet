import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/src/modules/home/home_view.dart';
import 'package:taukeet/src/modules/settings/settings_view.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFF0E7D8),
          secondary: const Color(0xFF191923),
        ),
      ),
      routerConfig: _router,
    );
  }
}
