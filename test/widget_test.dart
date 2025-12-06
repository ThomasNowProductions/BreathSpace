// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:BreathSpace/main.dart';
import 'package:BreathSpace/data.dart';
import 'package:BreathSpace/theme_provider.dart';
import 'package:BreathSpace/settings_provider.dart';
import 'package:BreathSpace/pinned_exercises_provider.dart';

void main() {
  testWidgets('BreathSpaceApp displays correctly', (WidgetTester tester) async {
    // Load exercises first
    await loadBreathingExercisesUsingSystemLocale();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
          ChangeNotifierProvider(create: (context) => PinnedExercisesProvider()),
        ],
        child: const BreathSpaceApp(seen: false),
      ),
    );

    // Verify that the IntroScreen is displayed.
    expect(find.byType(Text), findsWidgets);

    // Verify that exercises are loaded.
    expect(breathingExercises.length, greaterThan(0));
  });
}
