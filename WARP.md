# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

BreathSpace is a Flutter application for breathing exercises and meditation. The app features multiple breathing patterns, progressive exercises, multi-language support (12 languages), and customizable durations. It uses Provider for state management and includes both a mobile app and a web-based browser extension.

## Common Commands

### Development Setup
```bash
# Install dependencies
flutter pub get

# Generate localization files (required after adding/modifying translations)
flutter gen-l10n

# Run the app
flutter run

# Run on specific device
flutter run -d <device_id>
```

### Testing
```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code for issues
flutter analyze

# Format code
flutter format .
```

### Building
```bash
# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for web
flutter build web

# Build for Linux
flutter build linux

# Build for Windows
flutter build windows

# Build for macOS
flutter build macos
```

## Architecture Overview

### State Management Pattern

The app uses Provider (ChangeNotifier pattern) for state management with three main providers:

1. **ThemeProvider** (`lib/theme_provider.dart`): Manages light/dark theme switching
2. **SettingsProvider** (`lib/settings_provider.dart`): Manages user preferences including:
   - Language selection (12 languages supported)
   - View mode (list vs. AI-powered view)
   - Auto-select search bar setting
3. **PinnedExercisesProvider** (`lib/pinned_exercises_provider.dart`): Manages user's pinned exercises list

### Data Architecture

**Exercise Data Model** (`lib/data.dart`):
- `BreathingExercise`: Main exercise model with support for:
  - Simple exercises (single pattern/duration)
  - Multi-stage progressive exercises (gradual difficulty increase)
  - Exercise versions (short/normal/long variants)
  - Inhale/exhale method specifications (nose/mouth)
- `BreathingStage`: Individual stage in progressive exercises
- `ExerciseVersionData`: Version-specific pattern/duration/stages

**Data Loading**:
- Exercise data is stored in `assets/exercises.json` with translations for all 12 supported languages
- Loaded at app startup via `loadBreathingExercisesUsingSystemLocale()` or `loadBreathingExercisesForLanguageCode()`
- Exercise data includes multi-language support (title, intro) embedded in JSON

### Screen Flow

1. **IntroScreen** (`lib/intro_screen.dart`): First-time user welcome (shown only once)
2. **BreathingExerciseScreen** (in `lib/main.dart`): Main list view with search functionality
3. **GeminiExerciseScreen** (`lib/gemini_exercise_screen.dart`): AI-powered exercise interface using Google's Gemini API
4. **ExerciseDetailScreen** (`lib/exercise_detail_screen.dart`): Exercise details and version selection
5. **ExerciseScreen** (`lib/exercise_screen.dart`): Active exercise interface with breathing animations and timer
6. **ExerciseFinishedScreen** (`lib/exercise_finished_screen.dart`): Completion screen
7. **SettingsScreen** (`lib/settings_screen.dart`): User preferences

### Localization System

**Multi-tier localization approach**:

1. **UI Strings**: Using Flutter's gen-l10n (ARB files in `lib/l10n/`)
   - 12 languages: en, nl, de, es, fr, it, pt, ar, bg, ja, ru, zh
   - Template file: `lib/l10n/app_en.arb`
   - Generated files: `lib/l10n/app_localizations_*.dart`

2. **Exercise Data**: Embedded in `assets/exercises.json`
   - Each exercise has `title` and `intro` objects with language keys
   - Loaded dynamically based on selected language

**Key files**:
- `l10n.yaml`: Localization configuration
- `lib/l10n/app_localizations.dart`: Generated localization class

### Gemini AI Integration

The app includes an AI-powered mode using Google's Gemini API:
- **Service**: `lib/gemini_service.dart` handles API communication
- **Prompt Caching**: `lib/prompt_cache_service.dart` manages prompt cache for efficiency
- **API Key**: Loaded from `.env` file (not in version control)
- **Screen**: `lib/gemini_exercise_screen.dart` provides conversational interface

### Extension Directory

The project includes a browser extension component:
- `extension/`: Built Flutter web output for extension
- `breathspace-extension/`: Source files for browser extension (HTML/CSS/JS)

## Development Guidelines

### Code Style

- Follow Dart style guide (enforced by `analysis_options.yaml`)
- Use 2 spaces for indentation
- Keep lines under 80 characters when practical
- Use trailing commas for better formatting
- Prefer single quotes for strings
- File naming: `lowercase_with_underscores.dart`
- Class naming: `UpperCamelCase`

### Adding a New Exercise

1. Open `assets/exercises.json`
2. Add exercise object with all language translations:
```json
{
  "id": "unique-exercise-id",
  "pattern": "4-4-4-4",
  "duration": "5 min",
  "title": {
    "en": "English Title",
    "nl": "Dutch Title",
    ...
  },
  "intro": {
    "en": "English description",
    "nl": "Dutch description",
    ...
  }
}
```
3. For progressive exercises, add `stages` array with stage objects
4. For versioned exercises, add `versions` object with `short`, `normal`, `long` variants

### Adding a New Language

1. Create ARB file: `lib/l10n/app_<lang>.arb` (copy from `app_en.arb`)
2. Translate all strings in the ARB file
3. Run `flutter pub get && flutter gen-l10n`
4. Add language to `LanguagePreference` enum in `lib/settings_provider.dart`
5. Add dropdown option in `lib/settings_screen.dart`
6. Add translations to all exercises in `assets/exercises.json`

### Provider Usage Pattern

When creating or modifying providers:
- Extend `ChangeNotifier`
- Call `notifyListeners()` after state changes
- Use `Provider.of<T>(context, listen: false)` for non-UI logic
- Use `Consumer<T>` widget for UI that reacts to state changes
- Initialize providers in `main.dart` using `MultiProvider`
- Always remove listeners in `dispose()` methods

### Progressive Exercises

Progressive exercises use multiple stages with increasing difficulty. Pattern format: `inhale-hold-exhale-hold` (e.g., "4-4-4-4", "4-7-8", "5-5"). Duration is in seconds. See `docs/PROGRESSIVE_EXERCISES.md` for detailed format.

### Persistence

- User preferences stored via `shared_preferences` package
- Settings provider handles load/save of preferences
- First-time intro screen state stored with key `'seen'`

## Important Files

- `lib/main.dart`: App entry point, theme setup, provider initialization, main screen
- `lib/data.dart`: Exercise data models and loading logic
- `assets/exercises.json`: All exercise data with translations
- `lib/settings_provider.dart`: User preferences management
- `lib/l10n/app_en.arb`: English localization template (base for all translations)
- `pubspec.yaml`: Dependencies and asset configuration
- `analysis_options.yaml`: Dart analyzer configuration
- `.env`: Gemini API key (not in version control)

## Documentation

Comprehensive documentation is in the `docs/` directory:
- `docs/README.md`: Main documentation hub
- `docs/PROJECT_STRUCTURE.md`: Detailed directory structure
- `docs/STATE_MANAGEMENT.md`: Provider pattern usage
- `docs/PROGRESSIVE_EXERCISES.md`: Progressive exercise format
- `docs/STYLE_GUIDE.md`: Code style conventions
- `docs/TESTING.md`: Testing guidelines
- `docs/DESIGN_GUIDE.md`: UI/UX design principles
