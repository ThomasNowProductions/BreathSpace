# Data Models

This document describes the data models used in the BreathSpace application.

## Table of Contents

- [Exercise Model](#exercise-model)
- [ProgressiveExercise Model](#progressiveexercise-model)
- [Settings Model](#settings-model)
- [Statistics Model](#statistics-model)

## Exercise Model

The basic exercise model represents a single breathing exercise.

### Structure

```dart
class Exercise {
  final String id;
  final String pattern;
  final int duration;
  final Map<String, String> title;
  final Map<String, String> intro;
}
```

### Properties

- `id`: Unique identifier for the exercise
- `pattern`: Breathing pattern in the format "inhale-hold-exhale-hold"
- `duration`: Duration of the exercise in seconds
- `title`: Map of language codes to translated titles
- `intro`: Map of language codes to translated introductions

### Example

```json
{
  "id": "box-breathing",
  "pattern": "4-4-4-4",
  "duration": 240,
  "title": {
    "en": "Box Breathing",
    "nl": "Box Ademhaling"
  },
  "intro": {
    "en": "A simple technique to calm your mind and body.",
    "nl": "Een eenvoudige techniek om je geest en lichaam te kalmeren."
  }
}
```

## ProgressiveExercise Model

The progressive exercise model represents a multi-stage breathing exercise that increases in difficulty.

### Structure

```dart
class ProgressiveExercise {
  final String id;
  final String title;
  final String intro;
  final List<ExerciseStage> stages;
}

class ExerciseStage {
  final String title;
  final String pattern;
  final int duration;
}
```

### Properties

- `id`: Unique identifier for the exercise
- `title`: Title of the progressive exercise
- `intro`: Introduction to the progressive exercise
- `stages`: List of exercise stages

### Example

```json
{
  "id": "progressive-relaxation",
  "title": "Progressive Relaxation",
  "intro": "Start with simple breathing and gradually increase the depth and duration.",
  "stages": [
    {
      "title": "Easy Start",
      "pattern": "4-4-4-4",
      "duration": 120
    },
    {
      "title": "Deeper Breathing",
      "pattern": "5-5-5-5",
      "duration": 180
    },
    {
      "title": "Advanced Relaxation",
      "pattern": "6-6-6-6",
      "duration": 240
    }
  ]
}
```

## Settings Model

The settings model represents user preferences and configuration.

### Structure

```dart
class Settings {
  final String language;
  final bool darkMode;
  final bool notifications;
  final int defaultDuration;
}
```

### Properties

- `language`: User's preferred language code
- `darkMode`: Whether dark mode is enabled
- `notifications`: Whether notifications are enabled
- `defaultDuration`: Default duration for exercises

## Statistics Model

The statistics model tracks user exercise history and progress.

### Structure

```dart
class Statistics {
  final DateTime date;
  final String exerciseId;
  final int duration;
  final bool completed;
}
```

### Properties

- `date`: Date when the exercise was performed
- `exerciseId`: Identifier of the exercise
- `duration`: Actual duration of the exercise
- `completed`: Whether the exercise was completed