# Code Review Report — Three Screens & Router Linking
**Status:** APPROVED (with minor recommendation items)
**Date:** 260611 (11 June 2026)
**Author:** Senior Flutter Code Reviewer

## 1. Executive Summary
The implementation of `lib/app/router.dart` and the three target screens (`lib/features/recommendation/ai_picks_screen.dart`, `lib/features/wishlist/wishlist_screen.dart`, `lib/features/profile/profile_screen.dart`) is technically solid, clean, and complies with the core architecture. It adheres well to the GoRouter shell navigation and custom Cubit-driven states. 

Some minor violations of **design.md** rules exist regarding hardcoded spacing/padding/radius tokens and hardcoded text values (failing localization rules). These are detailed below and should be cleaned up.

---

## 2. File-by-File Review

### A. lib/app/router.dart
- **Architecture & Flow:** Excellent. Uses a `ShellRoute` enclosing the 5 bottom nav screens. All secondary sub-pages (e.g. `/product/:id`, `/checkout`, `/wishlist`) reside outside the shell, hiding the bottom bar, perfectly matching **Section 14** rules.
- **Issues:**
  - Hardcoded color values at lines 67-68 (`const Color(0xFF111111)` and `const Color(0xFF777777)`). They must use `AppColors.primary` and `AppColors.secondaryText`.
  - Hardcoded navigation bar label text (e.g. 'Home', 'AI Picks'). These should be localized using `AppLocalizations.of(context)`.

### B. lib/features/recommendation/ai_picks_screen.dart
- **Architecture & Flow:** Strong implementation. Correctly connects user preferences and product data using the Cubit states. Correctly configures the `ProductCard` to display the "AI PICK" badge.
- **Issues:**
  - **Token violation (Section 19.1):** Hardcoded paddings (lines 254, 296, 355) and radii (lines 257, 299, 358) should use `AppSpacing` and `AppRadius` tokens.
  - **Localization violation (Section 4):** Hardcoded English strings at lines 270 ('Edit'), 326 ('CATEGORIES'), 347 ('BUDGET'), 391 ('Style Profile Required'), 396 ('Set up...'), and 405 ('Setup Style Profile'). These must be migrated to `app_*.arb` files.

### C. lib/features/wishlist/wishlist_screen.dart
- **Architecture & Flow:** Approved. Leverages a 2-column grid and modular `ProductCard`. Correctly tracks item count dynamically via `WishlistCubit`.
- **Issues:**
  - **Localization violation:** Hardcoded strings at lines 106 ('Tap the heart icon...') and 115 ('Explore Products').

### D. lib/features/profile/profile_screen.dart
- **Architecture & Flow:** Approved. Clear options for orders, preferences, and language selection. Language selection bottom-sheet uses `LanguageCubit` correctly.
- **Issues:**
  - **Token violation:** Hardcoded bottom-sheet radius of `20.0` at line 23 (design spec requires `24.0` or `AppRadius.xl`). Hardcoded spacing at line 182, badge padding at line 220, and radius of `10.0` at line 223.
  - **Localization violation:** Hardcoded dialogue texts in `_showAboutDialog`, section header `'APP'` (line 257), and menu title `'About SeoulStyle AI'` (line 261).

---

## 3. General Design Recommendations
- **Product Card Badge:** The badges in `ProductCard` currently use `BorderRadius.all(Radius.circular(4.0))`. Consider updating to pill-shaped radius (`AppRadius.pillBorderRadius`) to align with **Section 22** of `design.md`.

---
*No unresolved questions for this review.*
