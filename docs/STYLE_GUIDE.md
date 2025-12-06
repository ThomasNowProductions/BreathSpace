# Style Guide

This document outlines the coding conventions and style guidelines for the BreathSpace project.

## Table of Contents

- [Dart Code Style](#dart-code-style)
- [File Naming](#file-naming)
- [Imports](#imports)
- [Naming Conventions](#naming-conventions)
- [Documentation](#documentation)
- [Widget Structure](#widget-structure)
- [State Management](#state-management)

## Dart Code Style

We follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style) with some project-specific additions:

- Use 2 spaces for indentation (no tabs)
- Lines should not exceed 80 characters
- Use trailing commas for better formatting
- Prefer single quotes for strings

## File Naming

- Use lowercase_with_underscores for file names
- Use descriptive names that clearly indicate the file's purpose
- Match file names to the main class/widget they contain when possible

Examples:
```
user_profile_screen.dart
exercise_timer.dart
breathing_animation.dart
```

## Imports

- Use relative imports for files within the project
- Use package imports for external packages
- Group imports in the following order:
  1. Dart SDK imports
  2. Flutter imports
  3. Package imports
  4. Relative imports
- Separate each group with a blank line
- Sort imports alphabetically within each group

Example:
```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../providers/settings_provider.dart';
```

## Naming Conventions

### Classes and Types

- Use UpperCamelCase for class names
- Use UpperCamelCase for typedefs
- Use UpperCamelCase for extensions

```dart
class UserProfileScreen extends StatelessWidget {
  // ...
}

typedef ExerciseCallback = void Function(Exercise exercise);

extension StringExtensions on String {
  // ...
}
```

### Variables and Functions

- Use lowerCamelCase for variable names
- Use lowerCamelCase for function and method names
- Use lowerCamelCase for library prefixes

```dart
final currentUser = User();
void startExercise() {
  // ...
}

import 'user_profile_screen.dart' as userProfile;
```

### Constants

- Use lowerCamelCase for constant variables
- Use UpperCamelCase for constant identifiers

```dart
const defaultDuration = 300;
static const DefaultDuration = 300;
```

## Documentation

### Comments

- Use `//` for inline comments
- Use `///` for documentation comments (DartDoc)
- Place comments above the code they refer to
- Write clear, concise comments that explain why, not what

### DartDoc

- Document all public APIs
- Start with a brief, single-sentence summary
- Use markdown for formatting
- Reference parameters with square brackets
- Provide examples when helpful

```dart
/// A breathing exercise with a specific pattern and duration.
///
/// The [pattern] defines the inhale-hold-exhale-hold timing.
/// The [duration] specifies how long the exercise should last in seconds.
class Exercise {
  /// Creates an exercise with the given [pattern] and [duration].
  ///
  /// The [duration] must be positive.
  Exercise(this.pattern, this.duration) : assert(duration > 0);
}
```

## Widget Structure

### Build Methods

- Keep build methods clean and readable
- Extract complex widgets into separate methods or classes
- Use meaningful names for extracted methods

```dart
class BreathingExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Breathing Exercise'),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BreathingAnimation(),
    );
  }
}
```

### Widget Composition

- Prefer composition over deep nesting
- Extract reusable components into separate widgets
- Use private widgets for implementation details

## State Management

- Use Provider for application state management
- Keep providers focused and specific
- Use ChangeNotifier for simple state objects
- Separate business logic from UI logic
- Follow the single responsibility principle

```dart
class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
```