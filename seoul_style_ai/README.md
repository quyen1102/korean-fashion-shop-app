# SeoulStyle AI — Flutter Application

This directory contains the main Flutter source code for the **SeoulStyle AI** Korean Fashion Shopping App.

---

## 🚀 App Implementation Status
The application is fully functional with simulated offline services. All core screens and states have been implemented:
- **Splash & Localization Selection**: Complete (supports Vietnamese, Korean, English).
- **Onboarding & Guest Credentials**: Complete.
- **Style Preference Screen**: Complete.
- **Home, Search, & Product Detail**: Complete.
- **Cart, Checkout, & Fake Payment (Phase 06)**: Complete.
- **AI Picks & Wishlist & Profile (Phase 07)**: Complete.

---

## 🛠 Prerequisites

Ensure you have the following installed on your system:
* **Flutter SDK**: `^3.22.0` or higher
* **Dart SDK**: `^3.4.0` or higher
* **Xcode** (for running iOS simulations on macOS)
* **Android Studio & SDK** (for running Android simulations)

---

## 📦 Getting Started

### 1. Install Dependencies
Run the following command in the `seoul_style_ai` folder to download the packages:
```bash
flutter pub get
```

### 2. Generate Localization Files
This application uses built-in Flutter localization. Generate the Dart code from ARB files using:
```bash
flutter gen-l10n
```

### 3. Run the App
Launch the app on a connected emulator or device:
```bash
flutter run
```

---

## 📁 Folder Structure

```text
lib/
├── app/
│   ├── app.dart              # MaterialApp configuration & Blocs setup
│   ├── router.dart           # GoRouter route declarations
│   └── theme/                # Global theme tokens (Colors, Spacing, Text styles)
├── core/
│   ├── cubit/                # Core level state (e.g. LanguageCubit)
│   └── widgets/              # Reusable layout widgets (buttons, input forms)
├── data/
│   ├── models/               # Data models (Product, CartItem, Order, UserPreference)
│   └── repositories/         # Mock data managers & local storage handlers
├── features/
│   ├── auth/                 # Login & authentication screen
│   ├── onboarding/           # Splash, language selector, and introduction
│   ├── home/                 # Main home screen & search listing
│   ├── product/              # Detailed product page & filters
│   ├── cart/                 # Cart screen & quantity cubit
│   ├── checkout/             # Payment processing & order success
│   ├── profile/              # User settings & preference editing
│   └── recommendation/       # AI Picks layout & scoring engine
└── l10n/
    ├── app_en.arb            # English localization resource
    ├── app_ko.arb            # Korean localization resource
    └── app_vi.arb            # Vietnamese localization resource
```

---

## 🛠 Packages Used
* `flutter_bloc` & `bloc`: Cubits for state management
* `go_router`: Declared navigation & route path transitions
* `shared_preferences`: Local settings persistence (language selection, order list, user preferences)
* `google_fonts`: Custom typographic styling
* `flutter_localizations`: System localization package

For design details, refer to the root [design.md](../design.md).
For project roadmap and progress, refer to [docs/project-roadmap.md](../docs/project-roadmap.md).
