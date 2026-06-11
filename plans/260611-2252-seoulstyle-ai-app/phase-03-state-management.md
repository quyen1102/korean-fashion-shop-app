# Phase 03 — State Management

## Context Links
- Design rules: [design.md](../../design.md) §19.2
- Phase 02: [phase-02-data-layer.md](./phase-02-data-layer.md)

## Overview
- **Priority**: High — tất cả UI screens phụ thuộc vào Cubits
- **Status**: Pending
- **Description**: Tạo tất cả Cubit/State classes. Logic nằm trong Cubit, không trong UI.

## Key Insights
- Dùng Cubit (không phải Bloc đầy đủ) — đơn giản hơn, đủ dùng cho app demo
- Mỗi Cubit có State class riêng với các trạng thái: initial, loading, loaded, error
- Recommendation engine là pure function (stateless scoring) trong `RecommendationService`
- Cart và Wishlist lưu in-memory (session), Preference lưu persistent qua SharedPreferences

## Cubit Architecture

### 1. LanguageCubit
```dart
// State: Locale (en | vi | ko)
// Actions: setLanguage(Locale), loadSavedLanguage()
// Storage: SharedPreferences key 'locale'
```

### 2. AuthCubit
```dart
// State: unauthenticated | authenticated(UserProfile)
// Actions: loginDemo(email, password), loginAsGuest(), logout()
// Logic: bất kỳ email + password >= 6 chars => success
// Storage: session only (không persist)
```

### 3. PreferenceCubit
```dart
// State: notSet | set(UserPreference)
// Actions: savePreference(styles, categories, priceLevel), loadPreference()
// Storage: SharedPreferences via PreferenceRepository
```

### 4. ProductCubit
```dart
// State: loading | loaded(products, filtered, sortOrder) | error
// Actions: loadProducts(), searchProducts(query), 
//          filterByCategory(cat), applyFilters(FilterOptions), 
//          sortProducts(SortOrder)
// enum SortOrder: popular, newest, priceLow, discountHigh
```

### 5. CartCubit
```dart
// State: CartState(items: List<CartItem>, totalAmount, discountAmount, shippingFee)
// Actions: addItem(product, size, color), removeItem(id), 
//          updateQuantity(id, qty), clearCart()
// Logic: shipping = 15.0 nếu total < 100, else 0 (free shipping demo)
//        discount = fake 10% nếu >= 3 items
// Storage: in-memory (session)
```

### 6. WishlistCubit
```dart
// State: WishlistState(productIds: Set<String>)
// Actions: toggleWishlist(productId), loadWishlist()
// Storage: SharedPreferences
```

### 7. RecommendationCubit
```dart
// State: loading | loaded(List<RecommendedProduct>)
// RecommendedProduct = Product + reason string (localized key)
// Actions: generateRecommendations(UserPreference, allProducts)
// Logic: scoring algorithm (xem design.md §20)
```

### 8. CheckoutCubit
```dart
// State: idle | processing | success(Order) | failed(String)
// Actions: selectPaymentMethod(method), processPayment(CartItems)
// Logic: fake delay 1.5s -> always success -> create Order -> emit success
```

## Recommendation Scoring Algorithm

```dart
class RecommendationService {
  static int calculateScore(Product p, UserPreference pref, List<String> likedIds) {
    var score = 0;
    // Style match: +3 per matching tag
    for (final tag in p.styleTags) {
      if (pref.favoriteStyles.contains(tag)) score += 3;
    }
    // Category match: +2
    if (pref.favoriteCategories.contains(p.category)) score += 2;
    // Trending: +2
    if (p.isTrending) score += 2;
    // Sale: +1
    if (p.isSale) score += 1;
    // Price level: +1
    if (p.priceLevel == pref.pricePreference) score += 1;
    // Liked similar (same category as liked): +3
    // (simplified: same styleTags intersection with liked products)
    return score;
  }

  static String buildReasonKey(Product p, UserPreference pref) {
    // Returns localization key like 'aiReasonStyleMatch' or 'aiReasonTrending'
    // UI sẽ translate key sang ngôn ngữ hiện tại
  }
}
```

## File Structure

```
lib/features/
├── auth/cubit/
│   ├── auth_cubit.dart
│   └── auth_state.dart
├── home/cubit/
│   ├── product_cubit.dart
│   └── product_state.dart
├── cart/cubit/
│   ├── cart_cubit.dart
│   └── cart_state.dart
├── wishlist/cubit/
│   ├── wishlist_cubit.dart
│   └── wishlist_state.dart
├── recommendation/
│   ├── cubit/
│   │   ├── recommendation_cubit.dart
│   │   └── recommendation_state.dart
│   └── service/
│       └── recommendation_service.dart
├── checkout/cubit/
│   ├── checkout_cubit.dart
│   └── checkout_state.dart
└── profile/cubit/
    ├── preference_cubit.dart
    └── preference_state.dart

lib/core/cubit/
├── language_cubit.dart
└── language_state.dart
```

## Implementation Steps

1. Tạo `LanguageCubit` + `LanguageState` — implement trước vì app.dart cần
2. Tạo `AuthCubit` + `AuthState`
3. Tạo `PreferenceCubit` + `PreferenceState`
4. Tạo `ProductCubit` + `ProductState` với filter/search/sort logic
5. Tạo `CartCubit` + `CartState` với price calculation
6. Tạo `WishlistCubit` + `WishlistState`
7. Tạo `RecommendationService` (pure function)
8. Tạo `RecommendationCubit` + `RecommendationState`
9. Tạo `CheckoutCubit` + `CheckoutState`
10. Đăng ký tất cả Cubits vào `MultiBlocProvider` trong `main.dart`

## Todo List
- [ ] LanguageCubit + State
- [ ] AuthCubit + State (demo login logic)
- [ ] PreferenceCubit + State
- [ ] ProductCubit + State (filter, search, sort)
- [ ] CartCubit + State (add/remove/qty/pricing)
- [ ] WishlistCubit + State
- [ ] RecommendationService (scoring algorithm)
- [ ] RecommendationCubit + State
- [ ] CheckoutCubit + State (fake payment)
- [ ] MultiBlocProvider setup trong main.dart
- [ ] Verify: Unit test manual cho scoring algorithm

## Success Criteria
- Tất cả Cubits emit đúng states
- Cart tính tổng tiền đúng
- Recommendation trả về sản phẩm có điểm cao nhất với preference test
- Checkout emit success sau 1.5s delay
- Language change reload app với locale mới
