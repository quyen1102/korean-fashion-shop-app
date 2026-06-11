# SeoulStyle AI — Project Changelog

All notable changes to the SeoulStyle AI project will be documented in this file.

---

## [1.0.0] - 2026-06-11

### Added
- **Phase 06 (Shopping Checkout Flow)**:
  - Added `CartScreen` listing items, selected size/color badges, quantity controllers, subtotal, 10% volume discount (for 3+ items), and free shipping threshold computations.
  - Added `CheckoutScreen` with dummy shipping address data and a selector for payment methods (Credit Card, KakaoPay, Bank Transfer, COD).
  - Added 1.5s non-dismissable fake payment processing overlay.
  - Added `PaymentSuccessScreen` displaying a unique generated order code, delivery estimations, and routing buttons.
  - Added persistent local storage for order records.
- **Phase 07 (AI Recommendation & Profile)**:
  - Added `AiPicksScreen` containing a preference chip summary card, custom scoring description, recommended products grid, and refresh functionality.
  - Integrated `RecommendationCubit` implementing simulated scoring criteria (e.g. style match: +3, category match: +2, trending: +2, sale: +1).
  - Integrated localized recommendation explanations (e.g. `aiReasonStyleMatch` -> *Recommended because you like Korean Minimal style*) inside `ProductDetailScreen`.
  - Added `WishlistScreen` keeping a local state of marked items and instantly updating heart shapes on Home/Search grid widgets.
  - Added `ProfileScreen` with user avatar card, redirect options, language picker modal, and a logout verification alert box.
- **Polish & QA**:
  - Implemented custom fade page transition routes using `go_router`.
  - Added minor scale transformations on product card clicks.
  - Configured localized translations inside `.arb` files.

### Changed
- Refactored `ProductDetailScreen` to show the correct dynamic AI reason card.
- Updated `design.md` checklist items to reflect complete feature validation.
- Overwrote templates in `seoul_style_ai/README.md` to offer comprehensive Dart build logs and instruction files.
