# Phase 05 — Core Screens (Home, Search, Product Detail)

## Context Links
- Design rules: [design.md](../../design.md) §13.6–13.8
- Phase 03: [phase-03-state-management.md](./phase-03-state-management.md)

## Overview
- **Priority**: High — đây là core shopping experience
- **Status**: Pending
- **Description**: Home screen, Search/Filter screen, Product Detail screen. Bottom navigation shell.

## Bottom Navigation Shell

5 tabs: **Home | Search | AI Picks | Cart | Profile**

```dart
// Shell route trong go_router
// CartCubit emit badge count cho Cart tab
// Persistent across tab switches
```

Ẩn bottom nav ở: Product Detail, Checkout, Payment Result.

---

## Screen 1: Home Screen (`/home`)

### Layout
```
SafeArea
└── CustomScrollView (slivers)
    ├── SliverAppBar (collapsible)
    │   ├── Greeting: "Hi, [Name] 👋"
    │   └── Search Bar (tappable → navigate to /search)
    ├── SliverToBoxAdapter: Main Banner (PageView auto-scroll)
    ├── SliverToBoxAdapter: Category Chips (horizontal scroll)
    ├── SliverToBoxAdapter: "AI Picks for You" section
    │   └── Horizontal ProductCard list (4 items)
    ├── SliverToBoxAdapter: "Trending in Korea" section
    │   └── Horizontal ProductCard list (4 items)
    └── SliverToBoxAdapter: "Sale Today" section
        └── 2-column ProductGrid (4 items)
```

### Main Banner
- PageView với 3 banners:
  1. "Seoul Spring Collection" — pastel pink background
  2. "AI Style Picks" — purple accent
  3. "Sale Up to 50%" — cream with product
- Auto-scroll mỗi 3.5s
- Dot indicator

### Section Component (reusable)
```dart
Widget _buildSection({
  required String title,
  required String? subtitle,
  VoidCallback? onViewAll,
  required Widget content,
})
```

### AI Picks Section
- Hiển thị 4 sản phẩm từ `RecommendationCubit`
- Mỗi card có badge "AI PICK" (màu tím #7C5CFF)
- Subtitle: "Based on your [style] preference"

---

## Screen 2: Search Screen (`/search`)

### Layout
```
Column
├── Search TextField (always focused when entering)
├── Filter Row: [Filter button] [Sort button] [Active filter chips]
├── Result count text: "24 products found"
└── GridView (2 columns, infinite scroll simulation)
    └── ProductCard
```

### Filter Bottom Sheet
Mở bằng `showModalBottomSheet` khi tap Filter:
```
Category: [All] [Tops] [Pants] [Dresses] [Shoes] [Bags] [Accessories]
Price: [Budget] [Medium] [Premium]
Type: [Sale only] [New arrivals] [Trending]
[Apply] [Reset]
```

### Sort Bottom Sheet
```
[ ] Popular
[ ] Newest
[ ] Price: Low to High
[ ] Highest Discount
```

### Empty State
```
Icon: search_off
"No products found"
"Try a different keyword or category"
```

### ProductCard (shared component)
```dart
class ProductCard extends StatelessWidget {
  // Image (3:4 ratio) với:
  //   - Badge: SALE / AI PICK / NEW / HOT (tối đa 2)
  //   - Wishlist heart icon (top right)
  //   - Loading shimmer khi image chưa load
  // Product name (max 2 lines, 14sp)
  // Brand (12sp, grey)
  // Price row: current + original + discount%
  // onTap → navigate to /product/:id
}
```

---

## Screen 3: Product Detail Screen (`/product/:id`)

### Layout
```
Stack
├── CustomScrollView
│   ├── SliverAppBar (image carousel, expandedHeight 60%)
│   │   └── PageView: product images (2-3 images)
│   │   └── Back button + Wishlist icon (absolute positioned)
│   └── SliverToBoxAdapter: product info section
│       ├── Badges row (SALE, AI PICK, NEW)
│       ├── Product name (20sp Bold)
│       ├── Brand (14sp grey)
│       ├── Rating row: stars + review count
│       ├── Price row
│       ├── AI Reason Card (nếu là AI recommended product)
│       ├── Size selector (S M L XL XXL chips)
│       ├── Color selector (colored circles)
│       ├── Description (expandable)
│       └── "You might also like" horizontal list (4 items same category)
└── Positioned bottom: Add to Cart bar
    ├── Price
    └── "Add to Cart" button (full width, black)
```

### AI Reason Card
```dart
Container(
  decoration: BoxDecoration(
    color: Color(0xFFF7F3FF),  // light purple
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    children: [
      Icon(Icons.auto_awesome, color: Color(0xFF7C5CFF)),
      Column(
        children: [
          Text("AI Recommended", style: purpleSemiBold),
          Text(aiReasonText, style: greyBody),  // localized reason
        ]
      )
    ]
  )
)
```

### Size Selector Logic
- Không chọn size → "Add to Cart" button disabled
- Chọn xong → button active

### Add to Cart
```dart
CartCubit.addItem(product, selectedSize, selectedColor)
=> Show SnackBar: "Added to cart ✓"  
```

## Shared Widgets (tạo trong core/widgets/)
- `ProductCard` — 2-column grid card + horizontal card variant
- `SectionHeader` — title + "View All" row
- `MainBanner` — auto-scroll PageView với indicators
- `PriceView` — current + original + discount badge
- `RatingRow` — star + review count
- `ProductGrid` — SliverGrid 2-column wrapper
- `ProductHorizontalList` — horizontal scrolling list
- `CategoryChipList` — horizontal scroll chip list
- `LoadingShimmer` — skeleton loading card
- `EmptyState` — icon + title + subtitle

## Todo List
- [ ] Bottom navigation shell (ShellRoute in go_router)
- [ ] `HomeScreen` — SliverAppBar, Banner, sections
- [ ] `MainBanner` widget (PageView + auto-scroll + dots)
- [ ] `ProductCard` widget (grid + horizontal variants)
- [ ] `SectionHeader` widget
- [ ] `CategoryChipList` widget
- [ ] `SearchScreen` — search, filter sheet, sort sheet, grid
- [ ] Filter bottom sheet
- [ ] Sort bottom sheet
- [ ] `ProductDetailScreen` — image carousel, info, AI card, size/color
- [ ] `AIReasonCard` widget
- [ ] `AddToCartBar` (bottom sticky)
- [ ] `LoadingShimmer` widget
- [ ] `EmptyState` widget
- [ ] Connect ProductCubit to Search screen
- [ ] Connect CartCubit to cart badge in bottom nav
- [ ] Test: Home load, scroll, tap product, add to cart

## Success Criteria
- Home scroll mượt không jank
- Product grid load 40 sản phẩm không lag
- Search filter/sort hoạt động đúng
- Product detail hiển thị đầy đủ info
- Add to cart cập nhật badge trên tab
- AI Reason card hiển thị với sản phẩm AI recommended
- Wishlist icon toggle đúng
