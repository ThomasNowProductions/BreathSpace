# Project Structure

This document provides an overview of the BreathSpace project structure.

## Root Directory

```
.
├── android/              # Android-specific code
├── assets/               # Static assets (images, JSON files)
├── docs/                 # Documentation files
├── ios/                  # iOS-specific code
├── lib/                  # Main Flutter application code
├── linux/                # Linux-specific code
├── macos/                # macOS-specific code
├── test/                 # Unit and widget tests
├── web/                  # Web-specific code
├── windows/              # Windows-specific code
├── .gitignore            # Git ignore file
├── analysis_options.yaml # Dart analysis options
├── l10n.yaml             # Localization configuration
├── LICENSE               # Project license
├── pubspec.yaml          # Flutter package configuration
└── README.md             # Project README
```

## Lib Directory

The `lib` directory contains the main Flutter application code:

```
lib/
├── l10n/                 # Localization files (ARB format)
├── screens/              # UI screens
├── providers/            # State management (Provider pattern)
├── models/               # Data models
├── utils/                # Utility functions
├── widgets/              # Reusable UI components
├── constants/            # Application constants
└── main.dart             # Application entry point
```

## Assets Directory

The `assets` directory contains static assets used by the application:

```
assets/
├── exercises.json        # Exercise data in JSON format
├── images/               # Image assets
└── sounds/               # Audio files (if any)
```

## Docs Directory

The `docs` directory contains all project documentation:

```
docs/
├── README.md             # Main documentation
├── PROGRESSIVE_EXERCISES.md  # Progressive exercises documentation
├── index.md              # Documentation index
├── CONTRIBUTING.md       # Contributing guidelines
├── STYLE_GUIDE.md        # Code style guide
├── TESTING.md            # Testing guide
├── PROJECT_STRUCTURE.md  # This file
├── MODELS.md             # Data models documentation
├── STATE_MANAGEMENT.md   # State management documentation
├── CHANGELOG.md          # Release history
└── ROADMAP.md            # Future plans
```

## Test Directory

The `test` directory contains all application tests:

```
test/
├── unit/                 # Unit tests
├── widget/               # Widget tests
└── integration/          # Integration tests
```