# Phase 04 — Onboarding Flow

## Context Links
- Design rules: [design.md](../../design.md) §13.1–13.5
- Phase 03: [phase-03-state-management.md](./phase-03-state-management.md)

## Overview
- **Priority**: High
- **Status**: Pending
- **Description**: Toàn bộ flow trước khi vào main app: Splash → Language → Onboarding → Login → Style Preference

## Screens

### 1. Splash Screen (`/splash`)
**Design:**
- Background: `#FFF8F2` (Cream)
- Logo: Text "SeoulStyle AI" với font Noto Sans Bold 28sp
- Tagline nhỏ: "Discover Korean Fashion" (localized)
- Auto-navigate sau 2s

**Logic:**
```dart
onInit:
  1. Load saved locale => apply to LanguageCubit
  2. Check if user previously completed onboarding (SharedPreferences key 'onboarding_done')
  3. If yes AND preference saved => navigate to /home
  4. If yes but no preference => navigate to /style-preference
  5. If no => navigate to /language-select
```

---

### 2. Language Selection Screen (`/language-select`)
**Design:**
- Title: "Choose your language" (hardcode 3 ngôn ngữ vì chưa có locale)
- 3 large selectable cards:
  - 🇻🇳 Tiếng Việt
  - 🇰🇷 한국어
  - 🇺🇸 English
- Selected card: border đậm `#111111` + check icon
- Primary button: "Continue" (full width, bottom)

**Logic:**
- Tap card => select
- Tap Continue => `LanguageCubit.setLanguage()` → navigate to `/onboarding`

---

### 3. Onboarding Screen (`/onboarding`)
**Design:**
- 3 trang PageView:
  1. **Discover Korean Fashion** — ảnh fashion editorial
  2. **AI Picks Your Style** — ảnh AI/recommendation concept
  3. **Shop Faster, Easier** — ảnh shopping cart/checkout
- Indicator dots ở dưới
- Nút "Skip" (top right) → nhảy thẳng vào Login
- Nút "Next" / "Get Started" (page cuối) → vào Login

**Implementation notes:**
- Ảnh onboarding: tạo bằng màu pastel gradient (nếu không có real assets)
- Hoặc dùng ảnh từ `assets/images/onboarding/` (cần chuẩn bị 3 ảnh)

---

### 4. Login Screen (`/login`)
**Design (theo design.md §13.4):**
- Logo nhỏ ở top
- Title: "Welcome back" (localized)
- Email TextField
- Password TextField (có show/hide icon)
- "Login" button (primary)
- Divider "or"
- "Continue as Demo User" button (secondary)
- Social buttons (Google/Kakao) — chỉ UI, tap = SnackBar "Coming soon"

**Logic:**
```dart
Demo login:
- Email: bất kỳ format email hợp lệ
- Password: >= 6 chars
=> AuthCubit.loginDemo() => emit Authenticated
=> navigate to /style-preference (if first time) or /home
```

**Validation:**
- Email không đúng format: "Please enter a valid email"
- Password < 6 chars: "Password must be at least 6 characters"

---

### 5. Style Preference Screen (`/style-preference`)
**Design (theo design.md §13.5):**
- Section 1: "What style do you like?" — multi-select chips:
  - Minimal, Casual, Streetwear, Office, Luxury, Korean Style
- Section 2: "What items are you interested in?" — multi-select chips:
  - Tops, Pants, Dresses, Shoes, Bags, Accessories
- Section 3: "Preferred price range" — single-select chips:
  - Budget, Medium, Premium
- "Save & Continue" button (disabled until at least 1 style + 1 category + price selected)
- "Skip" link (small text, bottom)

**Logic:**
```dart
Save: PreferenceCubit.savePreference(styles, categories, price)
     => SharedPreferences.setBool('onboarding_done', true)
     => navigate to /home
Skip: navigate to /home with empty preference (AI picks sẽ show trending products)
```

## Shared Widgets (tạo trong core/widgets/)
- `AppPrimaryButton` — full-width black button
- `AppSecondaryButton` — outlined/light button  
- `AppTextField` — styled TextField theo design.md §23
- `SelectableChip` — chip selectable với active/inactive state
- `PageIndicator` — dots indicator cho onboarding

## Navigation (go_router)
```
/splash → /language-select → /onboarding → /login → /style-preference → /home
```
- Sau khi vào /home, back navigation không quay lại onboarding flow

## Todo List
- [ ] Tạo `SplashScreen` với auto-navigate logic
- [ ] Tạo `LanguageSelectScreen` với 3 language cards
- [ ] Tạo `OnboardingScreen` với PageView + dots
- [ ] Tạo `LoginScreen` với validation
- [ ] Tạo `StylePreferenceScreen` với multi-select chips
- [ ] Tạo shared widgets: AppPrimaryButton, AppSecondaryButton, AppTextField, SelectableChip
- [ ] Kết nối navigation flow qua go_router
- [ ] Test flow: mở lần đầu → chọn ngôn ngữ → onboarding → login → preference → home
- [ ] Test: mở lần 2 → auto-navigate đúng

## Success Criteria
- Flow chạy mượt từ đầu đến home
- Language selection thay đổi locale ngay lập tức
- Style preference lưu persistent (close + reopen app vẫn còn)
- Login validation hiển thị đúng error
- Back từ home không quay về onboarding

## UI Polish Checklist
- [ ] Không có text hardcode (tất cả qua l10n)
- [ ] Tiếng Hàn hiển thị đúng (Noto Sans KR)
- [ ] Không có text overflow
- [ ] Button states: active/disabled/loading
