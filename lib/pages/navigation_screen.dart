import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:tesla_animation/controller/home_controller.dart';
import 'package:tesla_animation/pages/climate_page.dart';
import 'package:tesla_animation/pages/battery_page.dart';
import 'package:tesla_animation/pages/home_screen.dart';
import 'package:tesla_animation/pages/settings_page.dart';

/// Main navigation screen with a glass bottom tab bar.
///
/// Uses [GlassScaffold] + [GlassTabBar.bottom] for the iOS 26
/// floating pill navigation with jelly-physics indicator.
class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  final HomeController _homeController = HomeController();
  late final List<Widget> _pages = [
    HomeScreen(),
    const ClimatePage(),
    const BatteryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      // Glass needs a controlled backdrop — gradient gives the refraction
      // layer something interesting to blur against.
      background: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [Color(0xFF1C1F26), Colors.black],
          ),
        ),
      ),
      statusBarStyle: GlassStatusBarStyle.auto,
      // ── Glass Bottom Navigation Bar ──
      bottomBar: GlassTabBar.bottom(
        selectedIndex: _homeController.selectedIndex,
        onTabSelected: (index) =>
            _homeController.updateThebottomSheetIndex(index),
        // iOS 26 floating pill — glass blur, jelly indicator, glow on press
        barHeight: 64,
        barBorderRadius: 32,
        verticalPadding: 12,
        horizontalPadding: 16,
        // Glow when a tab is tapped
        glowBlurRadius: 32,
        glowSpreadRadius: 8,
        glowOpacity: 0.6,
        // Jelly indicator
        showIndicator: true,
        indicatorColor: Colors.white.withValues(alpha: 0.15),
        indicatorPinchStrength: 0.4,
        // Icon / label colors
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.white54,
        selectedLabelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        iconSize: 24,
        labelFontSize: 11,
        // Quality — standard works smoothly on all devices
        quality: GlassQuality.standard,
        tabs: const [
          GlassTab(
            icon: Icon(Icons.lock_outline),
            activeIcon: Icon(Icons.lock),
            label: 'Doors',
          ),
          GlassTab(
            icon: Icon(Icons.thermostat_outlined),
            activeIcon: Icon(Icons.thermostat),
            label: 'Climate',
          ),
          GlassTab(
            icon: Icon(Icons.battery_full_outlined),
            activeIcon: Icon(Icons.battery_full),
            label: 'Battery',
          ),
          GlassTab(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      // ── Page Content ──
      body: _pages[_homeController.selectedIndex],
    );
  }
}
