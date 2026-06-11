# Phase 01 — Foundation

## Context Links
- Design rules: [design.md](../../design.md)
- Plan overview: [plan.md](./plan.md)

## Overview
- **Priority**: Critical — tất cả phase sau phụ thuộc vào phase này
- **Status**: Pending
- **Description**: Khởi tạo dự án Flutter, thiết lập toàn bộ design system, cấu trúc thư mục, routing, localization scaffold.

## Key Insights
- Project mới hoàn toàn, không có code sẵn
- Design system đã định nghĩa rõ trong `design.md` (màu, font, spacing, radius)
- Flutter i18n/l10n dùng ARB + `gen_l10n` (chính thức, không cần package ngoài)
- go_router phù hợp hơn Navigator 2.0 cho demo nhỏ này
- Noto Sans hỗ trợ đầy đủ tiếng Việt + Hàn + Latin qua `google_fonts`

## Requirements
- Flutter project tên `seoul_style_ai` (package name: `com.demo.seoul_style_ai`)
- Target: Android + iOS
- Cấu trúc thư mục theo feature-first
- Design tokens (màu, font, spacing, radius) dùng qua constants thay vì hardcode
- Routing khai báo trung tâm qua go_router
- ARB files scaffold 3 ngôn ngữ với ~50 keys ban đầu

## Architecture

```
lib/
├── app/
│   ├── app.dart              # MaterialApp.router setup
│   ├── router.dart           # go_router routes
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart
│       ├── app_radius.dart
│       └── app_theme.dart
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   └── widgets/              # shared widgets (empty shell)
│
├── features/                 # feature folders (empty shells)
│
├── data/
│   └── mock/                 # sẽ dùng ở phase 02
│
├── l10n/
│   ├── app_en.arb
│   ├── app_vi.arb
│   └── app_ko.arb
│
└── main.dart
```

## Implementation Steps

1. **Tạo Flutter project**
   ```bash
   flutter create --org com.demo --project-name seoul_style_ai seoul_style_ai
   ```
   
2. **Cập nhật `pubspec.yaml`** — thêm dependencies:
   - `flutter_bloc: ^8.1.6`
   - `go_router: ^13.2.1`
   - `shared_preferences: ^2.3.3`
   - `google_fonts: ^6.2.1`
   - `equatable: ^2.0.5`
   - `flutter_localizations` (built-in)
   - `intl: ^0.19.0`
   - Thêm assets: `assets/images/`, `assets/data/`

3. **Tạo design tokens** (`app_colors.dart`, `app_text_styles.dart`, `app_spacing.dart`, `app_radius.dart`)

4. **Tạo `app_theme.dart`** — `ThemeData` sử dụng tokens

5. **Tạo ARB files** — scaffold 50+ localization keys (EN/VI/KO)

6. **Cấu hình `l10n.yaml`** và chạy `flutter gen-l10n`

7. **Tạo `router.dart`** — khai báo tất cả routes (shell + full-screen)

8. **Tạo `app.dart`** — `MaterialApp.router` với `localizationsDelegates`, `supportedLocales`, `routerConfig`

9. **Tạo `main.dart`** — khởi tạo `SharedPreferences`, wrap với `MultiBlocProvider`

10. **Cấu trúc thư mục đầy đủ** — tạo tất cả feature folder shells

## Todo List
- [ ] Tạo Flutter project
- [ ] Cập nhật pubspec.yaml, chạy `flutter pub get`
- [ ] Tạo app_colors.dart
- [ ] Tạo app_text_styles.dart
- [ ] Tạo app_spacing.dart + app_radius.dart
- [ ] Tạo app_theme.dart
- [ ] Tạo 3 ARB files (en, vi, ko)
- [ ] Cấu hình l10n.yaml, chạy gen-l10n
- [ ] Tạo router.dart với tất cả route names
- [ ] Tạo app.dart
- [ ] Tạo main.dart
- [ ] Verify: `flutter run` không lỗi

## Success Criteria
- `flutter run` chạy được, hiển thị màn hình trắng (chưa có UI)
- `flutter analyze` không có lỗi nghiêm trọng
- Theme tokens có thể import và dùng từ bất kỳ file
- Localization generate thành công, `AppLocalizations.of(context)` có thể dùng

## Risk Assessment
- **Low**: Flutter setup trên Mac thường ổn định
- **Medium**: Korean font rendering trên Android emulator có thể cần test thực
