# Phase 06 — Shopping Flow (Cart → Checkout → Payment → Orders)

## Context Links
- Design rules: [design.md](../../design.md) §13.10–13.11, §12.8–12.10, §19.4
- Phase 03: [phase-03-state-management.md](./phase-03-state-management.md)

## Overview
- **Priority**: High — đây là luồng quan trọng nhất khi thuyết trình
- **Status**: Complete
- **Description**: Cart screen, Checkout screen, fake payment flow, Order Success screen, Order History screen.

## Screen 1: Cart Screen (`/cart` — tab)

### Layout
```
Scaffold
├── AppBar: "My Cart" + item count
└── Column
    ├── if empty: EmptyCartState
    └── if items:
        ├── Expanded: ListView của CartItemRow
        ├── Divider
        ├── OrderSummarySection
        │   ├── Subtotal
        │   ├── Discount (if any)
        │   ├── Shipping Fee
        │   └── Total (bold, larger)
        └── CheckoutButton (sticky bottom)
```

### CartItemRow Component
```
Row
├── Product Image (80x80, radius 12)
├── Column (Expanded)
│   ├── Product name (2 lines max)
│   ├── Size + Color chips (small)
│   ├── Price
│   └── Quantity Control: [-] [n] [+]
└── Remove icon (top right)
```

### Order Summary
```dart
// Subtotal = sum(item.price * item.qty)
// Discount = -10% if total >= 3 items (fake)
// Shipping = 15.0 if subtotal < 100 else 0 (free)
// Total = subtotal - discount + shipping
```

### Empty Cart State
```
Icon: shopping_bag_outlined
Title: "Your cart is empty"
Subtitle: "Explore Korean fashion now"
Button: "Start Shopping" → navigate to /search
```

---

## Screen 2: Checkout Screen (`/checkout`)

### Layout
```
Scaffold
├── AppBar: "Checkout"
└── SingleChildScrollView
    ├── Section: Shipping Address
    │   └── Demo address card (fake name + address)
    │   └── "Change" button (tap = SnackBar "Coming soon")
    ├── Section: Payment Method
    │   └── RadioListTile options:
    │       ├── 💳 Credit Card (Demo)
    │       ├── 🟡 KakaoPay (Demo)
    │       ├── 🏦 Bank Transfer (Demo)
    │       └── 💵 Cash on Delivery
    ├── Section: Order Summary
    │   ├── Product list (compact, image + name + price)
    │   ├── Subtotal
    │   ├── Discount
    │   ├── Shipping
    │   └── Total (bold)
    └── Sticky Bottom: "Pay Now" button
```

### Demo Shipping Address (hardcoded)
```
Kim Quyen
123 Gangnam-gu, Seoul, Korea
Phone: +82 010-1234-5678
```

### Payment Method Selection
```dart
// CheckoutCubit.selectPaymentMethod(method)
// Default selected: Cash on Delivery
```

---

## Screen 3: Payment Processing + Success

### Payment Loading
```
Full-screen overlay:
Center(
  Column(
    CircularProgressIndicator (black),
    SizedBox(height: 16),
    Text("Processing payment..." / localized),
  )
)
```
- Duration: 1.5 seconds
- Non-dismissable

### Payment Success Screen (`/payment-success`)
```
Scaffold (no AppBar)
└── Center
    └── Column
        ├── Lottie animation OR Icon(check_circle, size: 80, color: success green)
        ├── SizedBox(height: 24)
        ├── Text("Payment Successful!", style: headline, bold)
        ├── SizedBox(height: 8)
        ├── Text("Order #SS2026XXXX", style: body, grey)
        ├── Text("Estimated delivery: 3–5 business days", style: body)
        ├── SizedBox(height: 32)
        ├── Divider
        ├── SizedBox(height: 16)
        ├── AppPrimaryButton("View Order Details") → /order-history
        └── AppSecondaryButton("Back to Home") → /home (clear stack)
```

### After Payment Logic
```dart
CheckoutCubit.processPayment():
  1. await Future.delayed(1500ms)
  2. OrderRepository.createOrder(cartItems, paymentMethod)
     => generate Order ID: "SS2026" + timestamp
  3. CartCubit.clearCart()
  4. emit CheckoutSuccess(order)
  5. navigate to /payment-success
```

---

## Screen 4: Order History Screen (`/order-history`)

### Layout (accessible from Profile tab)
```
Scaffold
├── AppBar: "My Orders"
└── if empty: EmptyState("No orders yet")
   else: ListView của OrderCard
```

### OrderCard
```
Card(radius: 16)
└── Padding
    ├── Row: "Order #SS2026XXXX" + status chip
    ├── Row: date + payment method
    ├── Product list (compact): image + name (max 3 items, "+X more" if more)
    ├── Divider
    └── Row: Total amount + "View Details" button
```

### Order Status Chips
```
Processing: Orange background
Delivered: Green background
```

---

## Shared Widgets Needed
- `CartItemRow` — cart item with quantity control
- `OrderSummaryCard` — subtotal/discount/shipping/total display
- `CheckoutPaymentOption` — radio tile with icon
- `OrderCard` — order history card
- `PaymentSuccessWidget` — animated success display

## Navigation Flow
```
/cart → /checkout → (loading overlay) → /payment-success
/payment-success → /home (replaceAll, clear stack)
/payment-success → /order-history
```

## Todo List
- [x] `CartScreen` — list + summary + checkout CTA
- [x] `CartItemRow` widget (with quantity control)
- [x] `OrderSummarySection` widget
- [x] Empty cart state
- [x] `CheckoutScreen` — address + payment method + summary
- [x] Payment loading overlay
- [x] `PaymentSuccessScreen`
- [x] `OrderHistoryScreen` — list with OrderCard
- [x] `OrderCard` widget
- [x] Connect CheckoutCubit → fake payment flow
- [x] Connect CartCubit → clear after success
- [x] Connect OrderRepository → persist orders
- [x] Test: add items → checkout → pay → success → history shows order

## Success Criteria
- Cart tính đúng giá, discount, shipping
- Checkout hiển thị đúng order summary
- Payment success screen hiển thị sau 1.5s
- Order ID sinh ra sau mỗi đặt hàng
- Cart cleared sau payment success
- Order history hiển thị đơn hàng vừa đặt
- Back từ payment success về home (không back về checkout)
