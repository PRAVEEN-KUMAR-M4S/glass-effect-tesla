import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tesla_animation/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  final HomeController homeController;
  const HomeScreen({super.key, required this.homeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  /// final HomeController _homeController = HomeController();
  ///

  late AnimationController _batteryController;
  late Animation<double> _batteryAnimation;
  late Animation<Offset> _batteryStatusAnimation;

  int _previousIndex = 0;

  void setupBatteryAnimation() {
    _batteryController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _batteryAnimation = CurvedAnimation(
      parent: _batteryController,
      curve: Interval(0.0, 0.5),
    );

    _batteryStatusAnimation = _batteryStatusAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _batteryController,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
          ),
        );
  }

  void _handleTabChange() {
    final currentIndex = widget.homeController.selectedIndex;

    // Battery tab
    if (currentIndex == 1 && _previousIndex != 1) {
      _batteryController.forward(from: 0);
    } else if (currentIndex != 1 && _previousIndex == 1) {
      _batteryController.reverse();
    }

    _previousIndex = currentIndex;
  }

  @override
  void initState() {
    setupBatteryAnimation();
    widget.homeController.addListener(_handleTabChange);
    _previousIndex = widget.homeController.selectedIndex;
    super.initState();
  }

  @override
  void dispose() {
    _batteryController.dispose();
    widget.homeController.removeListener(_handleTabChange);
    super.dispose();
  }

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
          animation: Listenable.merge([
            _batteryController,
            widget.homeController,
          ]),
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constrains.maxWidth * 0.3,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Car.svg",
                        width: double.infinity,
                      ),
                    ),

                    AnimatedPositioned(
                      right: widget.homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.1
                          : constrains.maxWidth / 2.2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.homeController.selectedIndex == 0
                            ? 1
                            : 0,
                        child: DoorLock(
                          onTap: () => widget.homeController.updateDoorStatus(
                            Door.right,
                          ),
                          status: widget.homeController.isDoorLocked(
                            Door.right,
                          ),
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      left: widget.homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.1
                          : constrains.maxWidth / 2.2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.homeController.selectedIndex == 0
                            ? 1
                            : 0,
                        child: DoorLock(
                          onTap: () =>
                              widget.homeController.updateDoorStatus(Door.left),
                          status: widget.homeController.isDoorLocked(Door.left),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: widget.homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.4
                          : constrains.maxHeight / 2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.homeController.selectedIndex == 0
                            ? 1
                            : 0,
                        child: DoorLock(
                          onTap: () => widget.homeController.updateDoorStatus(
                            Door.front,
                          ),
                          status: widget.homeController.isDoorLocked(
                            Door.front,
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      bottom: widget.homeController.selectedIndex == 0
                          ? constrains.maxWidth * 0.4
                          : constrains.maxHeight / 2,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.homeController.selectedIndex == 0
                            ? 1
                            : 0,
                        child: DoorLock(
                          onTap: () =>
                              widget.homeController.updateDoorStatus(Door.back),
                          status: widget.homeController.isDoorLocked(Door.back),
                        ),
                      ),
                    ),

                    // AnimatedOpacity(
                    //   duration: const Duration(milliseconds: 400),
                    //   opacity: widget.homeController.selectedIndex == 1
                    //       ? 1.0
                    //       : 0.0,
                    //   child: SvgPicture.asset(
                    //     "assets/icons/Battery.svg",
                    //     width: constrains.maxWidth * 0.4,
                    //   ),
                    // ),
                    Opacity(
                      opacity: _batteryAnimation.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constrains.maxWidth * 0.4,
                      ),
                    ),

                    SlideTransition(
                      position: _batteryStatusAnimation,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: constrains.minHeight * 0.12,
                          top: 30,
                          left: 8,
                          right: 8,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "230 km",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text("54 %", style: TextStyle(fontSize: 24)),
                            Spacer(),
                            Text("CHARGING", style: TextStyle(fontSize: 20)),
                            Text(
                              "19 mins remaing",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: constrains.minHeight * 0.04),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text("22 km/hr"), Text("245 v")],
                              ),
                            ),
                          ],
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
