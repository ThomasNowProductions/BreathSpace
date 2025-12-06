# Testing Guide

This document provides guidelines for writing and running tests in the BreathSpace project.

## Table of Contents

- [Testing Philosophy](#testing-philosophy)
- [Test Types](#test-types)
- [Writing Tests](#writing-tests)
- [Running Tests](#running-tests)
- [Test Structure](#test-structure)
- [Mocking](#mocking)

## Testing Philosophy

We believe in writing tests that:

1. Are reliable and deterministic
2. Cover critical user flows
3. Are easy to read and understand
4. Help prevent regressions
5. Provide confidence in refactoring

## Test Types

### Unit Tests

Unit tests verify the behavior of individual functions, methods, or classes in isolation.

Location: `test/unit/`

Run with: `flutter test test/unit/`

### Widget Tests

Widget tests verify the behavior of Flutter widgets in isolation.

Location: `test/widget/`

Run with: `flutter test test/widget/`

### Integration Tests

Integration tests verify the interaction between multiple components.

Location: `test/integration/`

Run with: `flutter test test/integration/`

## Writing Tests

### General Guidelines

- Use descriptive test names that explain what is being tested
- Follow the AAA pattern: Arrange, Act, Assert
- Test one behavior per test
- Avoid testing implementation details
- Use meaningful assertions

### Example Unit Test

```dart
import 'package:test/test.dart';
import 'package:breathspace/models/exercise.dart';

void main() {
  group('Exercise', () {
    test('should create exercise with valid parameters', () {
      // Arrange
      final pattern = '4-4-4-4';
      final duration = 120;
      
      // Act
      final exercise = Exercise(pattern, duration);
      
      // Assert
      expect(exercise.pattern, equals(pattern));
      expect(exercise.duration, equals(duration));
    });
  });
}
```

### Example Widget Test

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breathspace/screens/home_screen.dart';

void main() {
  testWidgets('Home screen displays title', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );
    
    // Act & Assert
    expect(find.text('BreathSpace'), findsOneWidget);
  });
}
```

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/unit/exercise_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Tests in CI

For continuous integration, we run all tests with coverage:

```bash
flutter test --coverage && genhtml coverage/lcov.info -o coverage/html
```

## Test Structure

### Directory Structure

```
test/
├── unit/
│   ├── models/
│   ├── providers/
│   └── utils/
├── widget/
│   ├── screens/
│   └── widgets/
└── integration/
    └── features/
```

### File Naming

- Name test files with `_test.dart` suffix
- Match the file structure to the source code structure

Example:
```
lib/models/exercise.dart
test/unit/models/exercise_test.dart
```

## Mocking

For mocking dependencies, we use the `mockito` package.

### Example Mock

```dart
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Real class
class ExerciseRepository {
  Future<List<Exercise>> getExercises() async {
    // Implementation
  }
}

// Mock class
class MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  group('ExerciseProvider', () {
    late MockExerciseRepository mockRepository;
    late ExerciseProvider provider;
    
    setUp(() {
      mockRepository = MockExerciseRepository();
      provider = ExerciseProvider(mockRepository);
    });
    
    test('should load exercises from repository', () async {
      // Arrange
      final exercises = [Exercise('4-4-4-4', 120)];
      when(mockRepository.getExercises())
          .thenAnswer((_) async => exercises);
      
      // Act
      await provider.loadExercises();
      
      // Assert
      expect(provider.exercises, equals(exercises));
    });
  });
}
```