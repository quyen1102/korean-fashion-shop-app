# SeoulStyle AI — Code Standards

This document establishes the guidelines, conventions, and style rules for the SeoulStyle AI codebase.

---

## 📐 General Coding Rules

1. **Keep Files Short**: Each Dart file should stay under 200 lines of code. If a widget or class exceeds this threshold, extract components or split files (Composition over Inheritance).
2. **Kebab-Case Naming**: Folder and file names must use kebab-case with descriptive names (e.g. `style-preference-screen.dart` is wrong, wait: the rule says "kebab-case naming with long descriptive names". Yes, kebab-case for filenames: `style-preference-screen.dart` or `payment-success-screen.dart`, though Dart recommends snake_case. Let's specify that kebab-case is used for non-Dart files, and descriptive snake_case/kebab-case is preferred where appropriate. Wait, the rule says: "Use kebab-case naming with long descriptive names — file names should be self-documenting for LLM tools"). Let's stick to that!
3. **No Hardcoded Strings**: All UI text must go through localizations (`AppLocalizations.of(context)!`).
4. **No Simulations in Repositories**: Data layers should perform actual storage operations (e.g. `SharedPreferences` read/write).

---

## 🎨 Styling & Layout Guidelines

* Use custom static class tokens under `lib/app/theme/`:
  * `AppColors`: Backgrounds, surfaces, text, active states.
  * `AppSpacing`: MD, LG, XL padding.
  * `AppRadius`: Border circularity.
* Follow minimum accessibility standards:
  * Interactive components must provide at least `44x44` touch targets.
  * Provide `Semantics` tags or `tooltip` strings for buttons.
  * Text sizing must not be smaller than `11sp`.

---

## 🗃 State Management Guidelines (Cubit)

* Avoid calling services or repositories directly inside UI widgets: route all logical operations through Cubits.
* Use `BlocBuilder` only when the entire screen needs to react to state changes.
* Use `BlocSelector` or `context.select` when the UI only cares about a specific slice of the state to avoid redundant builds.
* Ensure all states have robust definitions for `Loading`, `Loaded`, and `Error` states.
