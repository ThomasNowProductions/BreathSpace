import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class BreathingExercise {
  final String title;
  final String pattern;
  final String duration;
  final String intro;

  const BreathingExercise({
    required this.title,
    required this.pattern,
    required this.duration,
    required this.intro,
  });

  factory BreathingExercise.fromJson(Map<String, dynamic> json) {
    return BreathingExercise(
      title: json['title'],
      pattern: json['pattern'],
      duration: json['duration'],
      intro: json['intro'],
    );
  }
}

late List<BreathingExercise> breathingExercises = [];

String _assetForLanguageCode(String? languageCode) {
  switch (languageCode) {
    case 'nl':
      return 'assets/exercises-nl.json';
    case 'en':
    default:
      return 'assets/exercises-en.json';
  }
}

Future<void> loadBreathingExercisesForLanguageCode(String? languageCode) async {
  final assetPath = _assetForLanguageCode(languageCode);
  final String response = await rootBundle.loadString(assetPath);
  final List<dynamic> data = json.decode(response);
  breathingExercises = data.map((json) => BreathingExercise.fromJson(json)).toList();
}

Future<void> loadBreathingExercisesUsingSystemLocale() async {
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  await loadBreathingExercisesForLanguageCode(code);
}
