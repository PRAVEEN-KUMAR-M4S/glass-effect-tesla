import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:tesla_animation/pages/navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-warm the liquid glass shaders so the first glass frame
  // renders without a white flash or first-frame jank.
  await LiquidGlassWidgets.initialize();

  // wrap() installs the accessibility bridge (Reduce Motion, High Contrast)
  // and the global glass theme scope.
  runApp(LiquidGlassWidgets.wrap(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesla Glass UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: NavigationScreen(),
      // liquid_glass_widgets is Material-free and does not provide a Material
      // ancestor — under MaterialApp, Text would show debug yellow underlines
      // without this one-line fix.
      builder: (context, child) =>
          Material(type: MaterialType.transparency, child: child!),
    );
  }
}
