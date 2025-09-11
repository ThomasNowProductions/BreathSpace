# OpenBreath

This app uses Flutter's gen-l10n for localization. Existing languages: English (`en`), Dutch (`nl`).

Files live in `lib/l10n/`:

- `lib/l10n/app_en.arb`
- `lib/l10n/app_nl.arb`

### Add a new language

1. Create a new ARB file in `lib/l10n/`, e.g. `app_es.arb` for Spanish.
2. Copy all keys from `app_en.arb` and translate the values.
3. Run:

   ```bash
   flutter pub get
   flutter gen-l10n
   ```

4. Rebuild the app. The new locale will be included automatically in `supportedLocales`.
5. To expose the language in Settings, add an entry to the language dropdown in `lib/settings_screen.dart` and the enum in `lib/settings_provider.dart`.

### Changing the app language at runtime

Use the Settings screen (`Settings > Language`) to choose:

- System default
- English
- Dutch

The choice is persisted with `shared_preferences` and applied on startup.

## Exercises content localization

Exercise data is localized via JSON files under `assets/`:

- `assets/exercises-en.json`
- `assets/exercises-nl.json`

The app selects which file to load based on the language setting (System, English, Dutch). If set to System, the device locale is used (falls back to English when unknown).

### Add or update exercise translations

1. Use `assets/exercises-en.json` as the source of truth for keys/rows.
2. Create a new file for the target language, e.g. `assets/exercises-de.json`.
3. Copy all items and translate `title`, `intro`, and (if needed) `duration` text. Do not change `pattern` values.
4. Wire the new language in code:
   - Add the language code mapping in `lib/data.dart` within `_assetForLanguageCode()`.
   - Add the language to the settings UI and enum in `lib/settings_provider.dart` and `lib/settings_screen.dart`.
5. Rebuild the app.

Notes:

- The app auto-reloads exercises when you change the language in Settings.
- Keep arrays in all language files aligned (same number and order of items) so pinned items remain consistent across languages.
