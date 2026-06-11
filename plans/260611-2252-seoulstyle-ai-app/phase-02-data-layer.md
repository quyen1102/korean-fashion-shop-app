# Phase 02 — Data Layer

## Context Links
- Design rules: [design.md](../../design.md) §19.3
- Plan overview: [plan.md](./plan.md)

## Overview
- **Priority**: High — State management phase phụ thuộc vào models
- **Status**: Pending
- **Description**: Định nghĩa models, tạo 40+ sản phẩm mock data JSON, viết repositories.

## Key Insights
- Toàn bộ data là local (JSON file trong assets)
- Product model cần đủ fields để filter, sort, recommendation scoring
- Nên dùng `fromJson` factory cho mỗi model
- Repository pattern giúp tách biệt data source với business logic
- Image: dùng URL Unsplash ổn định (unsplash.com/photos) hoặc placeholder màu pastel local

## Data Models

### Product
```dart
class Product extends Equatable {
  final String id;
  final String name;           // đa ngôn ngữ key hoặc hardcode EN
  final String brand;
  final String category;       // tops | pants | dresses | shoes | bags | accessories
  final double price;
  final double originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final List<String> imageUrls;
  final List<String> sizes;    // S | M | L | XL | XXL
  final List<String> colors;
  final List<String> styleTags; // minimal | casual | streetwear | office | luxury | korean
  final String priceLevel;     // budget | medium | premium
  final bool isTrending;
  final bool isNew;
  final bool isSale;
  final String description;
}
```

### UserPreference
```dart
class UserPreference extends Equatable {
  final List<String> favoriteStyles;
  final List<String> favoriteCategories;
  final String pricePreference;
  final List<String> viewedProductIds;
  final List<String> likedProductIds;
}
```

### CartItem
```dart
class CartItem extends Equatable {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  final int quantity;
}
```

### Order
```dart
class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String paymentMethod;
  final DateTime createdAt;
  final String status; // processing | delivered
  final String estimatedDelivery;
}
```

## Mock Data Plan

### Categories (7)
```
All, Tops, Pants, Dresses, Shoes, Bags, Accessories
```

### Products (40 items — 6-7 per category)

**Tops (7)**
1. Minimal White Oversized Shirt — minimal, korean — 35k KRW
2. Seoul Pastel Knit Cardigan — casual, korean — 52k KRW
3. Classic Striped Long Sleeve — casual — 28k KRW
4. Off-Shoulder Crop Blouse — korean, luxury — 45k KRW
5. Cozy Fleece Sweatshirt — streetwear, casual — 38k KRW
6. Structured Blazer Crop — office, minimal — 89k KRW
7. Sheer Layering Tank — minimal — 22k KRW

**Pants (6)**
8. Wide Leg Linen Trousers — minimal, office — 55k KRW
9. Cargo Street Pants — streetwear — 62k KRW
10. High-Waist Pleated Pants — korean, office — 48k KRW
11. Denim Straight Leg — casual — 65k KRW
12. Cozy Jogger Set — casual, streetwear — 42k KRW
13. Tailored Slim Trousers — office, minimal — 70k KRW

**Dresses (6)**
14. Korean Pleated Mini Dress — korean, casual — 58k KRW
15. Floral Wrap Midi Dress — casual — 65k KRW
16. Minimal Slip Dress — minimal, luxury — 72k KRW
17. Puff Sleeve A-line Dress — korean — 68k KRW
18. Oversized Shirt Dress — casual, minimal — 55k KRW
19. Velvet Evening Dress — luxury — 120k KRW

**Shoes (6)**
20. Clean White Chunky Sneakers — casual, streetwear — 89k KRW
21. Minimal Leather Loafers — minimal, office — 95k KRW
22. Platform Mary Janes — korean, luxury — 105k KRW
23. Street-Style High Tops — streetwear — 75k KRW
24. Soft Ballet Flats — casual, minimal — 55k KRW
25. Ankle Strap Heels — office, luxury — 115k KRW

**Bags (6)**
26. Mini Quilted Shoulder Bag — korean, luxury — 85k KRW
27. Daily Canvas Tote — casual, minimal — 45k KRW
28. Structured Leather Clutch — office, luxury — 95k KRW
29. Sporty Crossbody Pack — streetwear — 58k KRW
30. Soft Bucket Bag — casual, korean — 72k KRW
31. Chain Micro Bag — korean, luxury — 110k KRW

**Accessories (9)**
32. Slim Chain Necklace — minimal — 28k KRW
33. Pearl Drop Earrings — korean, luxury — 35k KRW
34. Wool Beanie — casual, streetwear — 22k KRW
35. Silk Square Scarf — minimal, luxury — 45k KRW
36. Simple Gold Bracelet — minimal — 32k KRW
37. Oversized Round Sunglasses — casual, korean — 38k KRW
38. Hair Claw Clip Set — korean, casual — 18k KRW
39. Structured Belt — office, minimal — 42k KRW
40. Phone Strap Charm — korean, streetwear — 25k KRW

> **Note**: Price dùng đơn vị số (VD: 35.0 = 350,000 VND / $35 / 35,000 KRW) — format theo locale

## Repositories

### ProductRepository
```dart
abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product?> getProductById(String id);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> filterProducts({
    String? category,
    String? priceLevel,
    bool? isSale,
    List<String>? styleTags,
  });
}
```

### PreferenceRepository
```dart
abstract class PreferenceRepository {
  Future<UserPreference?> getUserPreference();
  Future<void> saveUserPreference(UserPreference pref);
  Future<void> addViewedProduct(String productId);
  Future<void> toggleLikedProduct(String productId);
}
```

### OrderRepository
```dart
abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> createOrder(List<CartItem> items, String paymentMethod);
}
```

## Implementation Steps

1. Tạo models với `fromJson`/`toJson` và `Equatable`
2. Tạo `assets/data/products.json` với 40 sản phẩm
3. Tạo `assets/data/categories.json`
4. Thêm asset path vào `pubspec.yaml`
5. Tạo `MockProductRepository` đọc từ JSON
6. Tạo `LocalPreferenceRepository` dùng `SharedPreferences`
7. Tạo `LocalOrderRepository` dùng `SharedPreferences` (lưu order history)

## Todo List
- [ ] Tạo `data/models/product.dart`
- [ ] Tạo `data/models/user_preference.dart`
- [ ] Tạo `data/models/cart_item.dart`
- [ ] Tạo `data/models/order.dart`
- [ ] Tạo `assets/data/products.json` (40 products)
- [ ] Tạo `assets/data/categories.json`
- [ ] Tạo `data/repositories/product_repository.dart` (abstract)
- [ ] Tạo `data/repositories/mock/mock_product_repository.dart`
- [ ] Tạo `data/repositories/preference_repository.dart` (abstract)
- [ ] Tạo `data/repositories/local/local_preference_repository.dart`
- [ ] Tạo `data/repositories/order_repository.dart`
- [ ] Verify: parse JSON thành công, không có runtime error

## Success Criteria
- 40 products load được từ JSON
- Filter/search trả về đúng kết quả
- UserPreference lưu/đọc từ SharedPreferences
- Tất cả models có `==` và `hashCode` đúng (qua Equatable)
