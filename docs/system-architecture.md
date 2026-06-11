# SeoulStyle AI — System Architecture

This document describes the technical architecture, data flow, and directory structure of the SeoulStyle AI mobile application.

---

## 🏗 High-Level Architecture
The app follows a clean architecture pattern tailored for Flutter:

```text
+-----------------------------------------------------------+
|                       UI Layer (Widgets)                  |
|          Home, Search, Details, Cart, Checkout, Profile   |
+---------------------+-------------------------------------+
                      | Reads State / Dispatches Events
                      v
+---------------------+-------------------------------------+
|                  State Management Layer (Cubit)           |
|  Auth, Language, Product, Cart, Wishlist, Recommendation  |
+---------------------+-------------------------------------+
                      | Calls Services / Repositories
                      v
+---------------------+-------------------------------------+
|                   Data Layer (Mock Repositories)          |
|    Local storage (SharedPreferences), JSON Assets Db      |
+-----------------------------------------------------------+
```

---

## 🗄 Architecture Layers

### 1. Presentation Layer (UI & Widgets)
* **Screens & Modules**: Grouped by feature directories under `lib/features/`. Each feature holds its related screens and Cubits.
* **Global Widgets**: Standard UI components (primary buttons, inputs, product cards) are housed in `lib/core/widgets/`.
* **Design System Tokens**: Colors, Spacing, Border Radius, and Font weights are configured as static classes in `lib/app/theme/` to comply with the guidelines defined in `design.md`.

### 2. State Management Layer (Bloc/Cubit)
The application uses the `flutter_bloc` package to manage independent slices of application state:
* **`LanguageCubit`**: Manages the current locale (`en`, `ko`, `vi`) and saves user configuration persistently.
* **`AuthCubit`**: Manages user session state and guest login credentials.
* **`ProductCubit`**: Performs operations on clothing products (load list, keyword search, details filter).
* **`CartCubit`**: Handles cart actions (item add, quantities adjustments, volume-discount calculation, total price).
* **`WishlistCubit`**: Handles wishlist items and updates card heart states.
* **`RecommendationCubit`**: Implements the rule-based AI recommendation scoring logic.
* **`CheckoutCubit`**: Handles checkout steps, simulated payment processing (1.5s delay), and clearing carts.

### 3. Data & Repository Layer
* **Local Mock JSON**: Mock databases under `assets/data/` defining item names, prices, categories, trending status, and localized descriptions.
* **Repositories**:
  * `ProductRepository`: Accesses JSON data and filters entries.
  * `PreferenceRepository`: Persists user style preferences in `SharedPreferences`.
  * `OrderRepository`: Persists successfully checked-out orders in local memory.

---

## 🔄 Core Data Flows

### AI Recommendation Flow
1. User configures preferences on `/style-preference` (saved to `PreferenceRepository`).
2. Home screen or AI Picks tab dispatches `generateRecommendations`.
3. `RecommendationCubit` loads all products from `ProductRepository`.
4. It computes scores based on user tags and updates state:
   $$\text{Score} = (\text{Style Match} \times 3) + (\text{Category Match} \times 2) + (\text{IsTrending} \times 2) + (\text{IsSale} \times 1)$$
5. The list of items sorted by score is emitted to `AiPicksScreen`.

### Shopping Checkout Flow
1. User taps "Add to Cart" on a product detailed view (updates `CartCubit` state).
2. Cart screen computes prices and volume discounts.
3. User selects a payment method and clicks "Pay Now" on the checkout page.
4. `CheckoutCubit` dispatches `processPayment()`, loading a spinner overlay for 1.5 seconds.
5. `OrderRepository` creates a new order and returns a unique ID.
6. `CartCubit` is cleared, and navigation routes the user to `PaymentSuccessScreen`.
