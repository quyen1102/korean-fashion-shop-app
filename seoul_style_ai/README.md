# SeoulStyle AI

SeoulStyle AI is a minimal, modern Korean-style fashion shopping demo application built with Flutter. It features simulated AI recommendations, support for three languages (English, Vietnamese, Korean), and a complete checkout and shopping experience.

---

## 🛠 Setup & Run Instructions

Follow the steps below to set up and run the SeoulStyle AI application on your local machine:

### 1. Prerequisites
Ensure you have the following installed on your system:
* **Flutter SDK**: Version `^3.22.0` or higher
* **Dart SDK**: Version `^3.4.0` or higher
* **Xcode** (for iOS emulator support on macOS)
* **Android Studio & SDK** (for Android emulator support)

### 2. Install Dependencies
Open your terminal in the `seoul_style_ai` directory and run:
```bash
flutter pub get
```

### 3. Generate Localization Files
This application uses Flutter's built-in localization. Generate the Dart code from ARB resource files by running:
```bash
flutter gen-l10n
```

### 4. Run the Application
With a simulator running or a physical device connected, start the app using:
```bash
flutter run
```
