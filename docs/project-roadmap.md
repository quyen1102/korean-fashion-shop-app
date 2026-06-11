# SeoulStyle AI — Project Roadmap

This document outlines the development roadmap, current progress, milestones, and release phases of the SeoulStyle AI mobile application.

---

## 🎯 Project Overview
A modern fashion shopping app featuring custom local AI recommendations, offline data services, and robust multilingual capabilities (EN, VI, KO).

---

## 📊 Summary of Phases & Status

| Phase | Milestone | Focus Areas | Status | Target Date |
|:---:|---|---|:---:|:---:|
| **01** | **Foundation** | Cấu trúc dự án, theme, localization, dynamic language cubit | ✅ Complete | Jun 2026 |
| **02** | **Data Layer** | Models, JSON mock database, local repository | ✅ Complete | Jun 2026 |
| **03** | **State Management** | Khởi tạo Cubits (Cart, Wishlist, Recommendation, Auth) | ✅ Complete | Jun 2026 |
| **04** | **Onboarding Flow** | Splash screen, lang selector, dynamic preference select | ✅ Complete | Jun 2026 |
| **05** | **Core Screens** | Home screen (banner, listings), search + dynamic filters | ✅ Complete | Jun 2026 |
| **06** | **Shopping Flow** | Giỏ hàng, checkout summary, fake payment, order history | ✅ Complete | Jun 2026 |
| **07** | **AI & Profile** | AI picks logic, personalized reasons, profile page | ✅ Complete | Jun 2026 |
| **08** | **Polish & QA** | Animations, empty/error state handling, full QA validation | ✅ Complete | Jun 2026 |

---

## 🚀 Completed Milestones (Details)

### Phase 06 — Shopping Checkout Flow
* Added **Cart Screen (`/cart`)** with reactive quantity controllers, dynamic item counts, and automated calculation of shipping fees and volume discounts.
* Added **Checkout Screen (`/checkout`)** with user address rendering and multi-choice payment options (Credit Card, KakaoPay, Bank Transfer, COD).
* Embedded **Fake Payment Gateway** via a 1.5-second processing modal.
* Implemented **Payment Success Screen (`/payment-success`)** displaying Order details and routing back to home or order history.
* Built **Order History Screen (`/order-history`)** persistent through local repositories.

### Phase 07 — AI Recommendation & Profile
* Created **AI Picks Screen (`/ai-picks`)** displaying matched clothing based on the user's style tags.
* Implemented **Simulated Recommendation Engine** utilizing scoring algorithms to rank trending, on-sale, and preference-aligned items.
* Integrated **Custom AI Reason Cards** inside detailed product views explaining the recommendation logic in the active language.
* Added **Wishlist Screen (`/wishlist`)** synced in real-time across all product interactions.
* Implemented **Profile Screen (`/profile`)** featuring language switching, logout prompts, and user credentials.

---

## 🔮 Future Enhancements (Phase 09+)
1. **Real AI Recommendation Model Integration**: Connect backend endpoint (FastAPI/Node.js) leveraging Gemini API or a collaborative filtering engine.
2. **Real Payment Gateway Integration**: Connect Stripe or KakaoPay sandbox SDKs.
3. **Advanced Personal Styling Quiz**: Interactive survey using image selectors to dynamically narrow down stylistic choices.
4. **Offline Mode Synchronization**: Local SQLite backup syncing with an online database (Firebase Firestore) upon reconnection.
