import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:tesla_animation/controller/home_controller.dart';
import 'package:tesla_animation/pages/home_screen.dart';
import 'package:tesla_animation/pages/climate_page.dart';
import 'package:tesla_animation/pages/battery_page.dart';
import 'package:tesla_animation/pages/settings_page.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  final HomeController _controller = HomeController();

  final _pages = [
    HomeScreen(),
    const ClimatePage(),
    const BatteryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned.fill(child: _pages[_controller.selectedIndex]),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: GlassTabBar.bottom(
                    selectedIndex: _controller.selectedIndex,
                    onTabSelected: _controller.updateThebottomSheetIndex,
                    tabs: const [
                      GlassTab(icon: Icon(Icons.lock_outline), activeIcon: Icon(Icons.lock), label: 'Doors'),
                      GlassTab(icon: Icon(Icons.thermostat_outlined), activeIcon: Icon(Icons.thermostat), label: 'Climate'),
                      GlassTab(icon: Icon(Icons.battery_full_outlined), activeIcon: Icon(Icons.battery_full), label: 'Battery'),
                      GlassTab(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
