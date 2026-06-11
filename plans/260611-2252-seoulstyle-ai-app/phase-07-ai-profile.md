# Phase 07 — AI Picks Screen + Wishlist + Profile

## Context Links
- Design rules: [design.md](../../design.md) §13.9, §13.12, §20
- Phase 03: [phase-03-state-management.md](./phase-03-state-management.md)

## Overview
- **Priority**: High — AI tab là điểm nổi bật của app khi thuyết trình
- **Status**: Complete
- **Description**: AI Picks tab (điểm demo AI), Wishlist screen, Profile/Settings screen.

## Screen 1: AI Picks Screen (`/ai-picks` — tab)

### Layout
```
Scaffold
├── AppBar: [✨ AI icon] "AI Picks for You" 
└── CustomScrollView
    ├── SliverToBoxAdapter: Preference Summary Card
    ├── SliverToBoxAdapter: AI explanation text
    ├── SliverPadding + SliverGrid (2 columns): recommended products
    └── SliverToBoxAdapter: "Refresh Recommendations" button
```

### Preference Summary Card
```
Container (bg: #F7F3FF, radius: 20)
├── [✨ icon purple] "Based on your style profile"
├── Style tags: [Minimal] [Korean] [Casual] (chip row)
├── Categories: [Tops] [Shoes]
└── Price: Medium
```

### AI Explanation Text
```
"Showing 8 products matched to your taste.
 Scored by style match, trending status, and your liked items."
```
(localized per language)

### Product Grid
- Mỗi ProductCard trong tab này: luôn có badge "AI PICK" (tím)
- Khi tap xem detail, AI Reason Card sẽ hiện trong product detail

### AI Reason Text Generation
```dart
// Trong RecommendationService.buildReasonKey():
// Trả về localization key dựa trên dominant score reason:
if (styleMatchScore > 0) return 'aiReasonStyleMatch';      // "Matches your [style] style"
else if (product.isTrending) return 'aiReasonTrending';    // "Trending in Korea"
else if (product.isSale) return 'aiReasonSale';            // "On sale today"
else return 'aiReasonDefault';                              // "Recommended for you"

// ARB template:
// "aiReasonStyleMatch": "Recommended because you like {style} style.",
// Tiếng Hàn: "{style} 스타일을 선호하여 추천드립니다.",
// Tiếng Việt: "Được gợi ý vì bạn thích phong cách {style}.",
```

### Refresh Button
```dart
// Tap "Refresh" → RecommendationCubit.generateRecommendations()
// Show brief loading shimmer (500ms) → update list
// Trong demo: shuffle top-scored products
```

### Empty State (no preference set)
```
Icon: auto_awesome
"Set your style preference first"
Button: "Set Preferences" → navigate to /style-preference
```

---

## Screen 2: Wishlist Screen (`/wishlist`)

Accessible from Profile tab (không phải bottom nav riêng).

### Layout
```
Scaffold
├── AppBar: "Wishlist" + item count
└── if empty: EmptyState
   else: GridView (2 columns) của ProductCard (với filled heart)
```

### Empty State
```
Icon: favorite_border
"No items yet"
"Tap ♡ on products to save them"
Button: "Explore Products" → /search
```

### Wishlist ProductCard
- Same as `ProductCard` nhưng heart icon luôn filled (red)
- Long press → "Remove from wishlist?" dialog

---

## Screen 3: Profile Screen (`/profile` — tab)

### Layout
```
Scaffold
├── AppBar: "Profile"
└── ListView
    ├── UserInfoCard (avatar placeholder + name + email)
    ├── SectionGroup: "My Shopping"
    │   ├── ListTile: "Order History" → /order-history
    │   ├── ListTile: "Wishlist" → /wishlist
    │   └── ListTile: "Cart" (show count) → /cart
    ├── SectionGroup: "Preferences"  
    │   ├── ListTile: "Style Preferences" → /style-preference (edit mode)
    │   └── ListTile: "Language" → opens LanguageBottomSheet
    ├── SectionGroup: "App"
    │   ├── ListTile: "About" → simple dialog
    │   └── ListTile: "Logout" → confirmation dialog → back to /login
    └── Version text (bottom): "SeoulStyle AI v1.0.0 — Demo"
```

### User Info Card
```dart
// Demo user:
// Name: "Demo User" (or email username before @)
// Email: entered email or "demo@seoulstyle.ai" for guest
// Avatar: CircleAvatar với initials (not real photo)
```

### Language Bottom Sheet
```dart
showModalBottomSheet:
  Title: "Change Language"
  [✓] Tiếng Việt
  [ ] 한국어
  [ ] English
  Tap to select → LanguageCubit.setLanguage() → close sheet
```

### Logout Flow
```dart
showDialog: "Are you sure you want to logout?"
[Cancel] [Logout]
Logout: AuthCubit.logout() → navigate to /login (replace)
         + clear preference? (keep or ask - keep for demo)
```

### Style Preference Edit Mode
- Mở lại /style-preference với existing values pre-selected
- Save → update preference → update AI recommendations

---

## Localization Keys for AI Reasons

ARB keys cần thêm vào 3 file:
```json
{
  "aiPicksTitle": "AI Picks for You",
  "aiPicksSubtitle": "Based on your style profile",
  "aiReasonStyleMatch": "Recommended because you like {style} style.",
  "aiReasonTrending": "Trending in Korea right now.",
  "aiReasonSale": "On sale today — great deal for you.",
  "aiReasonDefault": "Recommended for you.",
  "aiReasonCategory": "Matches your interest in {category}.",
  "refreshRecommendations": "Refresh Recommendations",
  "wishlistTitle": "Wishlist",
  "wishlistEmpty": "No saved items yet",
  "profileTitle": "Profile",
  "orderHistory": "Order History",
  "stylePreferences": "Style Preferences",
  "language": "Language",
  "logout": "Logout",
  "logoutConfirm": "Are you sure you want to logout?",
  "appVersion": "SeoulStyle AI v1.0 — Demo"
}
```

## Todo List
- [x] `AiPicksScreen` — preference summary + grid + refresh
- [x] `PreferenceSummaryCard` widget
- [x] AI reason text generation in RecommendationService
- [x] `WishlistScreen` — grid with filled hearts
- [x] Wishlist empty state
- [x] `ProfileScreen` — user info + menu items
- [x] `UserInfoCard` widget
- [x] Language change bottom sheet
- [x] Logout confirmation dialog
- [x] Style preference edit mode (pre-fill existing data)
- [x] Add AI reason ARB keys (EN/VI/KO)
- [x] Connect RecommendationCubit to AI Picks screen
- [x] Connect WishlistCubit to wishlist screen + product cards
- [x] Test: set preference → AI picks shows relevant products
- [x] Test: change language → AI reason text changes

## Success Criteria
- AI Picks tab hiển thị products có điểm cao nhất với preference đã chọn
- Thay đổi preference → refresh → AI picks update
- AI reason text hiển thị đúng 3 ngôn ngữ
- Wishlist add/remove hoạt động từ cả product card và product detail
- Profile language change update toàn bộ app text
- Logout clear auth state, về màn login
