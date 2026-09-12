import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tesla_animation/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _homeController,
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constrains.maxWidth * 0.1,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Car.svg",
                        width: double.infinity,
                      ),
                    ),

                    Positioned(
                      right: constrains.maxWidth * 0.1,
                      child: DoorLock(
                        onTap: () =>
                            _homeController.updateDoorStatus(Door.right),
                        status: _homeController.isDoorLocked(Door.right),
                      ),
                    ),

                    Positioned(
                      left: constrains.maxWidth * 0.1,
                      child: DoorLock(
                        onTap: () =>
                            _homeController.updateDoorStatus(Door.left),
                        status: _homeController.isDoorLocked(Door.left),
                      ),
                    ),
                    Positioned(
                      top: constrains.maxWidth * 0.1,
                      child: DoorLock(
                        onTap: () =>
                            _homeController.updateDoorStatus(Door.front),
                        status: _homeController.isDoorLocked(Door.front),
                      ),
                    ),
                    Positioned(
                      bottom: constrains.maxWidth * 0.1,
                      child: DoorLock(
                        onTap: () =>
                            _homeController.updateDoorStatus(Door.back),
                        status: _homeController.isDoorLocked(Door.back),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DoorLock extends StatelessWidget {
  final VoidCallback onTap;
  final bool status;
  const DoorLock({super.key, required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedSwitcher(
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        switchInCurve: Curves.easeInOut,

        duration: const Duration(milliseconds: 300),
        child: SvgPicture.asset(
          status
              ? "assets/icons/door_lock.svg"
              : "assets/icons/door_unlock.svg",
          key: ValueKey(status),
        ),
      ),
    );
  }
}
