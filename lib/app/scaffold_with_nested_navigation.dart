import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/generated/l10n.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, -5), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            destinations: [
              NavigationDestination(
                label: S.of(context)!.home,
                icon: const Icon(Icons.home_outlined, size: 30.0),
                selectedIcon: const Icon(Icons.home, size: 30.0),
              ),
              NavigationDestination(
                label: S.of(context)!.qiblah, // New Qiblah tab
                icon: const Icon(Icons.explore_outlined, size: 30.0),
                selectedIcon: const Icon(Icons.explore, size: 30.0),
              ),
              NavigationDestination(
                label: S.of(context)!.settings,
                icon: const Icon(Icons.settings_outlined, size: 30.0),
                selectedIcon: const Icon(Icons.settings, size: 30.0),
              ),
            ],
            onDestinationSelected: _goBranch,
            surfaceTintColor: Colors.transparent,
            indicatorColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
            elevation: 0,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            height: 70,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
