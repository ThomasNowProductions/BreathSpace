# State Management

This document explains how state is managed in the BreathSpace application.

## Table of Contents

- [Overview](#overview)
- [Provider Pattern](#provider-pattern)
- [State Providers](#state-providers)
- [State Flow](#state-flow)
- [Best Practices](#best-practices)

## Overview

BreathSpace uses the Provider package for state management, which is a wrapper around InheritedWidget to make them more usable and reusable.

## Provider Pattern

We use the Provider pattern for:
- Global state management
- Dependency injection
- Rebuilding specific parts of the widget tree when state changes

### Basic Provider Usage

```dart
// Providing state
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
      ],
      child: MyApp(),
    ),
  );
}

// Consuming state
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return Text('Language: ${settings.language}');
      },
    );
  }
}
```

## State Providers

### SettingsProvider

Manages user preferences and settings.

```dart
class SettingsProvider with ChangeNotifier {
  String _language = 'en';
  bool _darkMode = false;
  
  String get language => _language;
  bool get darkMode => _darkMode;
  
  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }
  
  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}
```

### ExerciseProvider

Manages exercise data and selection.

```dart
class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  Exercise? _selectedExercise;
  
  List<Exercise> get exercises => _exercises;
  Exercise? get selectedExercise => _selectedExercise;
  
  void selectExercise(Exercise exercise) {
    _selectedExercise = exercise;
    notifyListeners();
  }
  
  void loadExercises() async {
    // Load exercises from JSON
    _exercises = await _loadExercisesFromAssets();
    notifyListeners();
  }
}
```

### TimerProvider

Manages the exercise timer state.

```dart
class TimerProvider with ChangeNotifier {
  bool _isRunning = false;
  int _secondsRemaining = 0;
  
  bool get isRunning => _isRunning;
  int get secondsRemaining => _secondsRemaining;
  
  void startTimer(int duration) {
    _isRunning = true;
    _secondsRemaining = duration;
    notifyListeners();
    
    // Timer logic
  }
  
  void pauseTimer() {
    _isRunning = false;
    notifyListeners();
  }
  
  void resetTimer() {
    _isRunning = false;
    _secondsRemaining = 0;
    notifyListeners();
  }
}
```

## State Flow

1. **Initialization**: Providers are initialized at app startup
2. **Loading**: Data is loaded from assets or persisted storage
3. **User Interaction**: User actions trigger state changes through provider methods
4. **Notification**: Providers notify listeners of state changes
5. **UI Update**: Widgets rebuild with new state
6. **Persistence**: Important state changes are persisted to shared preferences

### Example Flow

```dart
// 1. User selects an exercise
exerciseProvider.selectExercise(exercise);

// 2. UI updates to show selected exercise
Consumer<ExerciseProvider>(
  builder: (context, provider, child) {
    if (provider.selectedExercise != null) {
      return ExerciseDetailScreen(
        exercise: provider.selectedExercise!,
      );
    }
    return ExerciseListScreen();
  },
);

// 3. User starts timer
timerProvider.startTimer(provider.selectedExercise!.duration);

// 4. Timer updates UI
Consumer<TimerProvider>(
  builder: (context, provider, child) {
    return Text('${provider.secondsRemaining} seconds remaining');
  },
);
```

## Best Practices

1. **Keep providers focused**: Each provider should have a single responsibility
2. **Use immutable data**: Avoid mutating state directly; use methods that call `notifyListeners()`
3. **Minimize rebuilds**: Use `Consumer` widgets strategically to rebuild only necessary parts
4. **Handle async operations**: Use async/await in provider methods and update state appropriately
5. **Dispose resources**: Override `dispose()` method to clean up resources
6. **Error handling**: Handle errors gracefully and provide feedback to the user
7. **Testing**: Write tests for provider methods to ensure correct state transitions

### Example with Error Handling

```dart
class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  bool _isLoading = false;
  String? _error;
  
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Exercise> get exercises => _exercises;
  
  Future<void> loadExercises() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _exercises = await _loadExercisesFromAssets();
    } catch (e) {
      _error = 'Failed to load exercises';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```