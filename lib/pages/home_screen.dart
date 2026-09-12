import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tesla_animation/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController;
  const HomeScreen({super.key, required this.homeController});

  /// final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      // Glass refracts and blurs whatever sits behind it — give it a
      // controlled background instead of the plain black scaffold.
      background: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [Color(0xFF1C1F26), Colors.black],
          ),
        ),
      ),
      statusBarStyle: GlassStatusBarStyle.auto,

      body: SafeArea(
        child: AnimatedBuilder(
          animation: homeController,
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constrains.maxWidth * 0.4,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Car.svg",
                        width: double.infinity,
                      ),
                    ),

                    AnimatedPositioned(
                      right: homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.1
                          : constrains.maxWidth / 2.2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: homeController.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          onTap: () =>
                              homeController.updateDoorStatus(Door.right),
                          status: homeController.isDoorLocked(Door.right),
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      left: homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.1
                          : constrains.maxWidth / 2.2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: homeController.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          onTap: () =>
                              homeController.updateDoorStatus(Door.left),
                          status: homeController.isDoorLocked(Door.left),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.5
                          : constrains.maxHeight / 2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: homeController.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          onTap: () =>
                              homeController.updateDoorStatus(Door.front),
                          status: homeController.isDoorLocked(Door.front),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      bottom: homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.5
                          : constrains.maxHeight / 2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: homeController.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          onTap: () =>
                              homeController.updateDoorStatus(Door.back),
                          status: homeController.isDoorLocked(Door.back),
                        ),
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
      child: Center(
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
      ),
    );
  }
}
