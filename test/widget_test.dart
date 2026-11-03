import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hud_companion_app/main.dart';

void main() {
  testWidgets('RevCompanionApp renders cockpit and switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const RevCompanionApp());
    await tester.pumpAndSettle();

    // Verify Brand title is visible
    expect(find.text('COMPANION'), findsOneWidget);
    expect(find.text('REV Smart Cockpit'), findsOneWidget);

    // Initial tab is Cockpit (label visible)
    expect(find.text('Cockpit'), findsOneWidget);

    // Switch to Rides tab via icon
    await tester.tap(find.byIcon(Icons.alt_route_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Ride Logbook'), findsOneWidget);
    expect(find.text('Rides'), findsOneWidget);

    // Switch to Vehicle tab via icon
    await tester.tap(find.byIcon(Icons.tune_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Vehicle & Cockpit'), findsOneWidget);
    expect(find.text('KTM Duke 390'), findsOneWidget);
    expect(find.text('Vehicle'), findsOneWidget);

    // Switch back to Cockpit
    await tester.tap(find.byIcon(Icons.dashboard_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Dispatch to HUD'), findsOneWidget);

    // Tap preset 'Home' destination to test HUD dispatch
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('ACTIVE ON HUD'), findsOneWidget);
  });
}
