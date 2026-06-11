# SeoulStyle AI — Korean Fashion AI Shopping App

> A minimal, modern Korean-style fashion shopping demo application implemented in Flutter. It features simulated AI recommendations, support for 3 languages (Vietnamese, Korean, English), a complete shopping checkout flow with fake payment integration, and offline local data storage.

---

## 🚀 Status Update
All development phases have been successfully implemented:
* **Phase 06 (Shopping Flow)**: Fully implemented (Cart, Checkout, Fake Payment, Order Success, and Order History screens).
* **Phase 07 (AI & Profile Flow)**: Fully implemented (AI Picks recommendation engine & tab, Wishlist, Profile settings with localization switching).

---

## 📁 Project Structure

```text
fashion-korean/
├── README.md                 # Project Overview (This file)
├── design.md                 # Core UI & UX Design Rules
├── docs/                     # Detailed Project Documentation
│   ├── project-roadmap.md    # Living document tracking phases and progress
│   ├── project-changelog.md  # Detailed record of all significant changes
│   ├── system-architecture.md# Technical architecture details
│   ├── codebase-summary.md   # Structure and directory summary
│   └── code-standards.md     # Code guidelines and rules
├── plans/                    # Phase planning and details
│   └── 260611-2252-seoulstyle-ai-app/
│       ├── plan.md           # Implementation plan overview
│       ├── phase-06-shopping-flow.md
│       ├── phase-07-ai-profile.md
│       └── ...
└── seoul_style_ai/           # Flutter Application Directory (source code)
```

For app setup and execution guidelines, please refer to [seoul_style_ai/README.md](./seoul_style_ai/README.md).

---

## 🛠 Features Overview

### 1. Multi-language Support
* Fully localized in **English (en)**, **Vietnamese (vi)**, and **Korean (ko)**.
* No hardcoded text: all messages use `.arb` localization bundles and a dynamic `LanguageCubit`.
* Locale picker in onboarding and profile bottom sheet.

### 2. Onboarding & Authentication Flow
* Beautiful Splash Screen & Language Selection.
* Animated Intro slider detailing core features.
* One-click demo credential entry ("Continue as Demo User") or local credentials.
* Style Preference Selection (Chips to select favorite fashion styles, item categories, and budget level).

### 3. Core Shopping Screen Flow
* **Home Screen**: Features a promotional banner, horizontal categories, personalized AI Picks list, Trending items, and Daily Discounts.
* **Search Screen**: Advanced search field with keyword matching and interactive filters (Category, Color, Size, Price range) utilizing a bottom sheet.
* **Product Detail Screen**: Large multi-image carousel, interactive size/color picker, specific simulated AI recommendation reason, and similar items section.

### 4. Phase 06 — Shopping Checkout Flow (Complete)
* **My Cart (`/cart`)**: Dynamically lists added items with interactive quantity adjustments (`[-]` / `[+]`) and removal options. Automatically computes subtotal, free shipping thresholds, and volume-based discounts.
* **Checkout Screen (`/checkout`)**: Pre-seeded demo shipping address card, multiple payment options (Credit Card, KakaoPay, Bank Transfer, Cash on Delivery).
* **Fake Payment Integration**: Non-dismissable 1.5-second processing overlay simulating payment gateway validation.
* **Payment Success Screen (`/payment-success`)**: Displays an animated success indicator, auto-generated unique Order ID, and options to View Orders or Back to Home.
* **Order History (`/order-history`)**: Keeps a persistent local list of orders using an SQLite/SharedPreferences Repository.

### 5. Phase 07 — AI Recommendation & Profile Flow (Complete)
* **AI Picks Tab (`/ai-picks`)**: A dedicated tab featuring user style preference tags, explanation of the scoring rules, and a list of recommended products. Includes a "Refresh Recommendations" button that shuffles items with a shimmer effect.
* **Simulated AI Scoring System**: Rule-based engine scoring products based on style matching (+3), categories matching (+2), trending (+2), sale items (+1), and wishlist affinity (+3).
* **AI Reason Display**: Customized product details show localized explanations of the recommendation (e.g., *Recommended because you like Korean Minimal style* / *Được gợi ý vì bạn thích phong cách tối giản Hàn Quốc*).
* **Wishlist Screen (`/wishlist`)**: Interactive grid listing liked items with instantaneous sync across all product cards and product detail views.
* **Profile Settings (`/profile`)**: User information card, redirects for Order History, Wishlist, Cart, Preference edit mode, Language picker bottom sheet, and logout confirmation.

---

## 💡 Technical Stack
* **Framework**: Flutter (Dart)
* **State Management**: flutter_bloc (Cubit pattern)
* **Navigation**: go_router
* **Local Storage**: shared_preferences
* **Styling**: Tailored design tokens (Colors, Typography, Spacing, Radius) following `design.md`.

---

## 📖 Related Documents
* Design rules and UI guidelines: [design.md](./design.md)
* Roadmap and milestones: [docs/project-roadmap.md](./docs/project-roadmap.md)
* System Architecture: [docs/system-architecture.md](./docs/system-architecture.md)
