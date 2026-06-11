# SeoulStyle AI — Codebase Summary

This document provides a summary of the codebase structure, files, and mock databases.

---

## 📁 Folder Structure & Main Subsystems

* **`lib/app/`**: Application configuration.
  * `app.dart`: App root injection.
  * `router.dart`: Routing configurations.
  * `theme/`: Static tokens following `design.md`.
* **`lib/core/`**: Shared core systems.
  * `cubit/`: Language switching.
  * `widgets/`: Primary components.
* **`lib/data/`**: Repositories and local DBs.
  * `models/`: Models like `Product`, `Order`, `CartItem`, etc.
  * `repositories/`: Simulated storage and data interfaces.
* **`lib/features/`**: Modules separated by concerns.
  * `auth/`: Authentication flow.
  * `onboarding/`: Intros and splash.
  * `home/`: Base search and front pages.
  * `product/`: Detailed display pages.
  * `cart/`: Shopping basket.
  * `checkout/`: Simulated payment processing.
  * `profile/`: Account settings.
  * `recommendation/`: AI Picks list.

---

## 🗄 Databases (Assets)
* **`assets/data/products.json`**: Contains ~40 detailed items with localized translation keys, colors, pricing, sizes, categories, and style scores.
* **`assets/data/categories.json`**: Defines style tags and catalog entries.
