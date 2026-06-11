# Phase 08 — Polish, QA & Demo Preparation

## Context Links
- Design rules: [design.md](../../design.md) §15–18, §24–26
- Plan overview: [plan.md](./plan.md)

## Overview
- **Priority**: Medium-High — quyết định ấn tượng khi demo
- **Status**: Pending
- **Description**: Micro-animations, loading/empty/error states, a11y, navigation edge cases, final QA theo checklist design.md §26.

## 1. Animations

### Page Transitions
```dart
// go_router custom transition
CustomTransitionPage(
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(opacity: animation, child: child);
  },
  transitionDuration: Duration(milliseconds: 250),
)
```

### ProductCard Tap Animation
```dart
// InkWell với splash + scale transform
GestureDetector(
  onTapDown: (_) => setState(() => _scale = 0.96),
  onTapUp: (_) => setState(() => _scale = 1.0),
  child: AnimatedScale(scale: _scale, duration: Duration(milliseconds: 150), ...)
)
```

### Banner Auto-scroll
- `PageController` với `Timer.periodic(3.5s)`

### Loading Shimmer
- `AnimatedContainer` với gradient animation (không cần package)
- Màu shimmer: từ `#F5F5F5` đến `#EBEBEB`

### Add to Cart Success
- SnackBar với icon ✓ và "Added to cart"
- Duration: 2s, action: "View Cart"

### Wishlist Toggle
- Heart icon animated scale: `AnimationController` → 0.8 → 1.2 → 1.0 trong 300ms

---

## 2. Loading States

| Screen | Loading UI |
|--------|-----------|
| Home sections | Shimmer cards (2x4 grid placeholder) |
| Product Grid | Shimmer grid cards |
| Product Detail | Shimmer skeleton (image + text blocks) |
| AI Picks | Shimmer 2-column grid |
| Order History | Shimmer list items |
| Payment | Full-screen loading (spinner + text) |

---

## 3. Empty States

| Screen | Empty Message |
|--------|--------------|
| Cart | "Your cart is empty. Start exploring!" |
| Wishlist | "No saved items yet. Tap ♡ to save." |
| Search | "No products found. Try another keyword." |
| Order History | "No orders yet. Time to shop!" |
| AI Picks (no pref) | "Set your preferences to get AI picks." |

---

## 4. Error States

App dùng local data → không có network error. Chỉ cần:
- JSON parse error: log + show "Something went wrong. Please restart app."
- SharedPreferences read fail: use default values

---

## 5. Navigation Edge Cases

- **Back from Home**: double-tap back to show exit dialog
- **Back from Payment Success**: nút back disabled, chỉ dùng "Back to Home" button
- **Deep link từ notification**: không cần trong demo
- **Tab switch**: preserve scroll position (AutomaticKeepAliveClientMixin)

---

## 6. Text Overflow Prevention

Kiểm tra tất cả screens với tiếng Hàn (dài nhất) và tiếng Việt:
- Product name: `maxLines: 2, overflow: TextOverflow.ellipsis`
- Brand: `maxLines: 1, overflow: TextOverflow.ellipsis`
- Button text: `overflow: TextOverflow.ellipsis` + `padding` linh hoạt
- Badge text: không quá dài (max 10 chars)

---

## 7. Accessibility Checklist

- [ ] Icon buttons có `Semantics(label: ...)` hoặc `tooltip`
- [ ] Product images có `semanticLabel`
- [ ] Form fields có `labelText` đúng
- [ ] Minimum touch target 44x44px cho tất cả buttons/icons
- [ ] Color contrast: text `#1A1A1A` trên `#FAFAFA` = đạt WCAG AA
- [ ] Không chỉ dùng màu để thể hiện trạng thái

---

## 8. Korean Font Verification

```dart
// Đảm bảo google_fonts load offline được
// Thêm font fallback trong pubspec.yaml:
fonts:
  - family: NotoSansKR
    fonts:
      - asset: assets/fonts/NotoSansKR-Regular.ttf
      - asset: assets/fonts/NotoSansKR-Bold.ttf
        weight: 700
```

Hoặc dùng `GoogleFonts.notoSans()` nếu có internet khi demo.

> **IMPORTANT**: Demo thuyết trình nên có font cached offline. Test trên thiết bị thật trong airplane mode.

---

## 9. Demo Data Preparation

Đảm bảo data đẹp khi demo:

### Default Demo User (guest)
```dart
name: "Quyen"
email: "demo@seoulstyle.ai"
favoriteStyles: ['korean', 'minimal']
favoriteCategories: ['tops', 'shoes']
pricePreference: 'medium'
```

### Pre-seeded Order History (optional)
Thêm 1-2 fake orders cũ trong local storage khi app khởi động lần đầu (để Order History không trống khi demo).

### Pre-filled Wishlist
Thêm 3-4 sản phẩm vào wishlist mặc định khi demo user login.

---

## 10. Performance Checks

- Product images: dùng `FadeInImage` với placeholder
- ListView items: `const` constructors khi có thể
- Cubit rebuilds: dùng `BlocSelector` thay `BlocBuilder` khi chỉ cần một phần state
- GridView: `cacheExtent: 500` để pre-render cards ngoài viewport

---

## 11. Final QA Checklist (theo design.md §26)

```
[ ] Splash screen hoàn chỉnh
[ ] Chọn ngôn ngữ hoạt động
[ ] App đổi được Việt / Hàn / Anh
[ ] Login demo hoạt động
[ ] Style preference lưu được
[ ] Home có banner, category, AI Picks, Trending, Sale
[ ] Search/filter hoạt động
[ ] Product detail đầy đủ thông tin
[ ] Wishlist hoạt động
[ ] Cart thêm/xóa/tăng giảm số lượng hoạt động
[ ] Checkout hoạt động
[ ] Fake payment success hoạt động
[ ] Order history có đơn hàng sau thanh toán
[ ] Profile có đổi ngôn ngữ và xem preference
[ ] Không có text overflow
[ ] Không có crash khi back navigation
[ ] UI đồng nhất màu, font, radius, spacing
[ ] Chạy được trên Android thật (test offline)
[ ] Font tiếng Hàn hiển thị đúng (không bị lỗi ký tự)
```

---

## 12. Demo Flow Script (cho thuyết trình)

```
1. Mở app → Splash (2s) → Language Selection
2. Chọn 한국어 → Onboarding (skip or view) → Login
3. Tap "Continue as Demo User" → Style Preference
4. Chọn: Korean Style + Minimal / Tops + Shoes / Medium
5. Save → Home screen với AI Picks hiện sản phẩm liên quan
6. Scroll Home → thấy AI Picks, Trending, Sale sections
7. Tap sản phẩm trong AI Picks → Product Detail
8. Thấy "AI Recommended" card với lý do bằng tiếng Hàn
9. Chọn Size M → "장바구니에 담기" → SnackBar thành công
10. Vào Cart tab → xem giỏ hàng → Checkout
11. Chọn KakaoPay → "결제하기"
12. Loading 1.5s → Payment Success screen
13. "주문 보기" → Order History hiển thị đơn hàng
14. Profile tab → đổi sang Tiếng Việt → app đổi ngôn ngữ
15. Vào AI Picks tab → thấy lý do gợi ý bằng tiếng Việt
```

## Todo List
- [ ] Page transition animations (fade)
- [ ] ProductCard tap scale animation
- [ ] Wishlist heart animation
- [ ] Add to cart SnackBar with action
- [ ] Shimmer loading widgets for all data screens
- [ ] All empty states implemented
- [ ] Error state fallback
- [ ] Back navigation: home double-tap exit dialog
- [ ] Payment success back button blocked
- [ ] Tab scroll position preserved
- [ ] Text overflow prevention audit
- [ ] Accessibility labels
- [ ] Korean font offline test
- [ ] Demo data pre-seeding
- [ ] Performance audit (no jank on scroll)
- [ ] Full QA checklist run
- [ ] Test on real Android device (offline mode)

## Success Criteria
- App pass 100% của design.md §26 checklist
- Demo flow script chạy mượt không lỗi
- Font tiếng Hàn đúng trên thiết bị thật
- Không có text overflow ở bất kỳ ngôn ngữ nào
- App responsive từ 360px đến 430px width
