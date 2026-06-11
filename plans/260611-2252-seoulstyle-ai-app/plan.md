---
title: SeoulStyle AI — Flutter Fashion Shopping Demo App
description: App mua sắm thời trang Hàn Quốc với AI recommendation mô phỏng, hỗ trợ 3 ngôn ngữ (Việt/Hàn/Anh), luồng mua hàng đầy đủ, thanh toán fake. Demo đại học.
status: completed
priority: high
effort: large
branch: main
tags: [flutter, mobile, fashion, ai-demo, i18n, bloc, go_router]
created: 2026-06-11
---

# SeoulStyle AI — Implementation Plan

## App Overview
Demo app mua sắm thời trang Hàn Quốc. Không backend thật, không thanh toán thật. Trọng tâm: UI đẹp + luồng hoàn chỉnh + AI recommendation mô phỏng + đa ngôn ngữ.

## Phases

| # | Phase | Mô tả | Status |
|---|-------|--------|--------|
| 01 | [Foundation](./phase-01-foundation.md) | Setup project Flutter, cấu trúc thư mục, theme, localization | ✅ Completed |
| 02 | [Data Layer](./phase-02-data-layer.md) | Models, mock JSON data (~40 sản phẩm), repositories | ✅ Completed |
| 03 | [State Management](./phase-03-state-management.md) | Cubits: Auth, Language, Product, Cart, Wishlist, Recommendation, Checkout | ✅ Completed |
| 04 | [Onboarding Flow](./phase-04-onboarding.md) | Splash → Language → Onboarding → Login → Style Preference | ✅ Completed |
| 05 | [Core Screens](./phase-05-core-screens.md) | Home, Search/Filter, Product List, Product Detail | ✅ Completed |
| 06 | [Shopping Flow](./phase-06-shopping-flow.md) | Cart, Checkout, Fake Payment, Order Success, Order History | ✅ Completed |
| 07 | [AI & Profile](./phase-07-ai-profile.md) | AI Picks screen + recommendation engine, Wishlist, Profile | ✅ Completed |
| 08 | [Polish & QA](./phase-08-polish-qa.md) | Animations, empty/error states, a11y, navigation fix, demo prep | ✅ Completed |

## Key Dependencies
- Flutter SDK ≥ 3.22
- flutter_bloc ^8.x (Cubit)
- go_router ^13.x
- shared_preferences ^2.x
- google_fonts ^6.x
- flutter_localizations (built-in)
- cached_network_image ^3.x (optional)

## Target
- Android + iOS
- Portrait only (phone)
- Offline hoàn toàn (local mock data)
