import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:tesla_animation/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Two pumps let the glass scopes settle and the first glass frame paint.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }

  testWidgets('home screen renders the liquid glass scaffold with four door locks',
      (WidgetTester tester) async {
    await pumpApp(tester);

    // HomeScreen is built on the liquid-glass scaffold.
    expect(find.byType(GlassScaffold), findsOneWidget);

    // One frosted glass disc per door: front, back, left, right.
    expect(find.byType(GlassContainer), findsNWidgets(4));

    // All doors start unlocked (door_unlock.svg carries ValueKey(false)).
    expect(find.byKey(const ValueKey<bool>(false)), findsNWidgets(4));
  });

  testWidgets('tapping a door lock locks it', (WidgetTester tester) async {
    await pumpApp(tester);

    // Tap the first door-lock glass disc.
    await tester.tap(find.byType(GlassContainer).first);
    await tester.pump(const Duration(milliseconds: 350));

    // The icon switched from unlocked to locked.
    expect(find.byKey(const ValueKey<bool>(false)), findsNWidgets(3));
    expect(find.byKey(const ValueKey<bool>(true)), findsOneWidget);
  });
}
