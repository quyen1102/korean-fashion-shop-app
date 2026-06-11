# Design Rules — Fashion AI Shopping App

> Tài liệu quy định phong cách thiết kế, UI rules, component rules và nguyên tắc triển khai giao diện cho dự án Flutter app mua sắm thời trang có AI recommendation.  
> App phục vụ mục tiêu demo dự án đại học, hỗ trợ 3 ngôn ngữ: Tiếng Việt, 한국어, English.

---

## 1. Mục tiêu thiết kế

Ứng dụng cần tạo cảm giác:

- Hiện đại, tối giản, thời trang.
- Phù hợp với gu thẩm mỹ Hàn Quốc.
- Dễ dùng, dễ hiểu, không quá nhiều chức năng phức tạp.
- Có cảm giác là app shopping thật dù dữ liệu và thanh toán là demo.
- Thể hiện rõ điểm nổi bật: AI gợi ý sản phẩm theo sở thích cá nhân.

Thiết kế nên đi theo hướng:

```text
Clean Korean Fashion UI
Minimal Layout
Soft Pastel Accent
Large Product Image
Rounded Card
Premium but Friendly
```

Không thiết kế theo hướng quá màu mè, quá trẻ con, quá nhiều hiệu ứng hoặc quá giống app thương mại điện tử đại trà.

---

## 2. Đối tượng người dùng

Người dùng mục tiêu trong demo:

- Sinh viên, người trẻ yêu thích thời trang.
- Người quan tâm phong cách Hàn Quốc.
- Người muốn tìm sản phẩm nhanh hơn thông qua gợi ý cá nhân hóa.
- Người dùng phổ thông, không cần thao tác phức tạp.

Thiết kế phải ưu tiên:

- Dễ đọc.
- Dễ thao tác một tay.
- Dễ nhận biết sản phẩm sale, sản phẩm hot, sản phẩm được AI đề xuất.
- Luồng mua hàng ngắn, không làm người dùng rối.

---

## 3. Tính cách thương hiệu

Brand personality:

```text
Modern
Elegant
Minimal
Soft
Trendy
Korean-inspired
Personalized
```

Không dùng phong cách:

```text
Too playful
Too colorful
Too luxury-heavy
Too technical
Too corporate
```

App cần giống một thương hiệu thời trang trẻ, nhẹ nhàng, hiện đại, có yếu tố công nghệ AI nhưng không làm giao diện bị khô cứng.

---

## 4. Ngôn ngữ hỗ trợ

App hỗ trợ 3 ngôn ngữ:

```text
Vietnamese: vi
Korean: ko
English: en
```

### 4.1 Rule hiển thị text

- Không hardcode text trực tiếp trong widget.
- Tất cả text phải đi qua localization.
- Dùng file ARB:

```text
lib/l10n/app_vi.arb
lib/l10n/app_ko.arb
lib/l10n/app_en.arb
```

### 4.2 Rule độ dài text

Tiếng Hàn và tiếng Việt có thể dài hơn tiếng Anh ở một số vị trí. Vì vậy:

- Button phải có padding linh hoạt.
- Text trong card phải hỗ trợ tối đa 2 dòng.
- Title màn hình tối đa 1–2 dòng.
- Không dùng width cố định cho text.
- Ưu tiên `Expanded`, `Flexible`, `Wrap` khi cần.

### 4.3 Ngôn ngữ mặc định

- Lần đầu mở app: hiển thị màn chọn ngôn ngữ.
- Sau khi chọn, lưu ngôn ngữ bằng local storage.
- Nếu chưa chọn, mặc định dùng English hoặc theo system locale.

---

## 5. Design system tổng quan

### 5.1 Color palette

#### Light theme

```text
Background:        #FAFAFA
Surface:           #FFFFFF
Primary Text:      #1A1A1A
Secondary Text:    #777777
Disabled Text:     #BDBDBD
Primary:           #111111
Accent:            #E8B4B8
Accent Light:      #F4DDE2
Cream:             #FFF8F2
Border:            #EEEEEE
Sale:              #E53935
Success:           #2E7D32
Warning:           #F9A825
AI Badge:          #7C5CFF
```

#### Dark theme, optional for later

```text
Background:        #121212
Surface:           #1E1E1E
Primary Text:      #FFFFFF
Secondary Text:    #B0B0B0
Primary:           #FFFFFF
Accent:            #E8B4B8
Border:            #2C2C2C
Sale:              #FF6B6B
Success:           #66BB6A
AI Badge:          #9B8CFF
```

### 5.2 Color usage rules

- Primary màu đen/xám đậm dùng cho text chính, button chính.
- Accent hồng pastel dùng cho điểm nhấn thời trang.
- AI Badge dùng màu tím nhẹ để phân biệt sản phẩm AI đề xuất.
- Sale dùng đỏ nhưng không lạm dụng.
- Background luôn sáng, sạch, không dùng nền gradient quá nhiều.
- Banner có thể dùng ảnh thời trang hoặc nền pastel nhẹ.

Không dùng quá 3 màu chính trên cùng một màn hình.

---

## 6. Typography rules

### 6.1 Font đề xuất

Nên dùng font hỗ trợ tốt tiếng Việt, tiếng Hàn và tiếng Anh:

```text
Primary font: Noto Sans
Korean optimized: Noto Sans KR hoặc Pretendard
```

Nếu muốn đơn giản khi implement Flutter:

```text
Use GoogleFonts.notoSans()
```

### 6.2 Text style

```text
Display Large:   32sp / Bold
Headline Large:  28sp / Bold
Headline Medium: 24sp / SemiBold
Title Large:     20sp / SemiBold
Title Medium:    18sp / SemiBold
Body Large:      16sp / Regular
Body Medium:     14sp / Regular
Body Small:      12sp / Regular
Caption:         11sp / Medium
Button:          15sp / SemiBold
```

### 6.3 Typography rules

- Product name: 14–16sp, tối đa 2 dòng.
- Product price: 15–18sp, semi-bold hoặc bold.
- Original price: 12–14sp, màu xám, có gạch ngang.
- Section title: 18–22sp, semi-bold.
- Screen title: 22–28sp, bold.
- Không dùng font quá mỏng vì tiếng Hàn sẽ khó đọc.

---

## 7. Spacing system

Dùng hệ spacing chia hết cho 4 hoặc 8.

```text
xxs: 4
xs:  8
sm:  12
md:  16
lg:  24
xl:  32
xxl: 48
```

### Rule spacing

- Padding màn hình chính: 16px hoặc 20px.
- Khoảng cách giữa các section: 24px.
- Khoảng cách giữa title và content: 12px.
- Card padding: 12px hoặc 16px.
- Button height: 48–56px.
- Bottom navigation height: 64–72px.

Không dùng spacing lẻ như 13, 17, 19 trừ khi có lý do đặc biệt.

---

## 8. Border radius

```text
Small radius:    8
Medium radius:   12
Large radius:    16
XL radius:       24
Full pill:       999
```

### Rule radius

- Product card: 16px.
- Product image: 16px.
- Button: 14–16px.
- Search bar: 16px hoặc pill.
- Category chip: pill.
- Bottom sheet: top-left/top-right 24px.
- Dialog: 20px.

---

## 9. Shadow / elevation

Thiết kế app thời trang nên dùng shadow nhẹ.

```text
Card shadow:
blur: 12
spread: 0
opacity: 0.06
vertical offset: 4
```

### Rule shadow

- Không dùng shadow quá đậm.
- Product card có thể không cần shadow, chỉ dùng nền trắng và border nhẹ.
- Floating cart button hoặc checkout bar có thể dùng shadow nhẹ.
- Bottom navigation dùng border top hoặc shadow rất nhẹ.

---

## 10. Icon rules

- Icon line style, stroke vừa phải.
- Không dùng icon quá nhiều màu.
- Icon chính dùng màu `#111111` hoặc `#777777`.
- Icon active trong bottom navigation dùng `#111111` hoặc Accent.
- Wishlist heart active dùng Sale hoặc Accent.
- AI icon có thể dùng sparkle/magic icon màu tím.

Kích thước icon:

```text
Small: 16
Default: 24
Large: 32
```

---

## 11. Image rules

Vì app thời trang phụ thuộc nhiều vào hình ảnh, product image rất quan trọng.

### 11.1 Product image

- Ảnh sản phẩm phải rõ, nền sạch.
- Tỷ lệ ưu tiên: 3:4 hoặc 1:1.
- Product grid nên dùng ảnh lớn.
- Ảnh phải bo góc 16px.
- Khi loading ảnh, dùng placeholder màu `#F5F5F5`.
- Nếu ảnh lỗi, dùng fallback icon/image.

### 11.2 Banner image

- Banner nên có phong cách fashion editorial.
- Không dùng banner quá nhiều chữ.
- Text trên banner phải dễ đọc.
- Overlay nhẹ nếu ảnh quá sáng.

### 11.3 Demo assets

Có thể dùng ảnh local trong:

```text
assets/images/products/
assets/images/banners/
assets/images/onboarding/
```

---

## 12. Component rules

## 12.1 Primary Button

Dùng cho hành động chính:

- Add to Cart
- Checkout
- Pay Now
- Continue
- Save Preference

Style:

```text
Height: 52
Background: #111111
Text: #FFFFFF
Radius: 16
Font: 15sp SemiBold
```

State:

```text
Default: black background
Pressed: slightly darker/opacity 0.85
Disabled: #E0E0E0 background, #BDBDBD text
Loading: show small loading indicator
```

---

## 12.2 Secondary Button

Dùng cho hành động phụ:

- Cancel
- View more
- Change language
- Edit style profile

Style:

```text
Height: 48
Background: transparent or #F5F5F5
Text: #111111
Radius: 14
Border: optional #EEEEEE
```

---

## 12.3 Search Bar

Search bar là component quan trọng trên Home và Search screen.

Style:

```text
Height: 48–52
Background: #F5F5F5
Radius: 16 or pill
Icon: search icon 20–24
Text: 14–16sp
```

Rule:

- Luôn có placeholder theo ngôn ngữ.
- Có nút clear khi user nhập text.
- Không chiếm quá nhiều chiều cao màn hình.

---

## 12.4 Category Chip

Dùng để lọc sản phẩm.

Style inactive:

```text
Background: #F5F5F5
Text: #777777
Radius: pill
Padding horizontal: 16
Height: 36–40
```

Style active:

```text
Background: #111111
Text: #FFFFFF
```

Rule:

- Category nên scroll ngang.
- Không đặt quá nhiều category trong một hàng cố định.

---

## 12.5 Product Card

Product card là component chính của app.

Cấu trúc:

```text
[Image]
[Badge SALE / AI PICK / NEW]
[Wishlist icon]
[Product name]
[Brand]
[Price + original price]
[Rating optional]
```

Style:

```text
Width: flexible, grid 2 columns
Image ratio: 3:4
Card radius: 16
Image radius: 16
Card background: transparent or white
```

Rule:

- Tên sản phẩm tối đa 2 dòng.
- Giá phải nổi bật hơn brand.
- Badge không che quá nhiều ảnh.
- Wishlist icon đặt góc phải trên ảnh.
- Không đưa quá nhiều thông tin vào card.

---

## 12.6 AI Recommendation Card

Dùng để nhấn mạnh tính năng AI.

Cấu trúc:

```text
[AI icon]
AI Picks for You
Recommended based on your Minimal Korean style
[Product list horizontal/grid]
```

Style:

```text
Background: #F7F3FF hoặc #FFF8F2
Radius: 20
Accent: #7C5CFF
```

Rule:

- Luôn có lý do gợi ý ngắn gọn.
- Không dùng từ kỹ thuật quá phức tạp.
- Text nên thân thiện, ví dụ:
  - “Recommended because you like Korean minimal style.”
  - “Được gợi ý vì bạn thích phong cách tối giản Hàn Quốc.”
  - “미니멀한 한국 스타일을 선호하여 추천합니다.”

---

## 12.7 Price View

Hiển thị giá cần rõ ràng.

Rule:

- Giá hiện tại: màu đen, semi-bold/bold.
- Giá gốc: màu xám, gạch ngang.
- Discount badge: màu đỏ hoặc nền đỏ nhạt.

Ví dụ:

```text
$29.99   $39.99   -25%
```

---

## 12.8 Cart Item

Cấu trúc:

```text
[Product image]
[Product name]
[Size / Color]
[Price]
[-] quantity [+]
[Remove icon]
```

Rule:

- Image nhỏ tỷ lệ vuông hoặc 3:4.
- Quantity control dễ bấm.
- Remove icon không quá nổi bật.
- Tổng tiền hiển thị cố định ở dưới màn hình.

---

## 12.9 Checkout Summary

Cấu trúc:

```text
Subtotal
Discount
Shipping Fee
Total
```

Rule:

- Total phải nổi bật nhất.
- Các dòng phụ dùng màu secondary text.
- Checkout button cố định dưới màn hình.

---

## 12.10 Payment Result

Vì thanh toán là fake result, màn kết quả cần rõ ràng.

Success screen:

```text
Icon success
Payment Successful
Order ID
Estimated Delivery
Button: View Order
Button: Back to Home
```

Failed screen, optional:

```text
Icon failed
Payment Failed
Reason demo text
Button: Try Again
```

Rule:

- Demo nên ưu tiên success mặc định.
- Không cần nhập thông tin thẻ thật.
- Ghi rõ đây là demo nếu cần trong phần thuyết trình hoặc môi trường test.

---

## 13. Screen design rules

## 13.1 Splash Screen

Mục tiêu:

- Tạo cảm giác thương hiệu.
- Load ngôn ngữ đã lưu.

Cấu trúc:

```text
Logo / App name
Small tagline
Loading indicator optional
```

Style:

```text
Background: #FAFAFA hoặc #FFF8F2
Logo: simple fashion mark
Text: #111111
```

---

## 13.2 Language Selection Screen

Cấu trúc:

```text
Choose your language
[Tiếng Việt]
[한국어]
[English]
Continue
```

Rule:

- Mỗi ngôn ngữ là một card hoặc button lớn.
- Ngôn ngữ đang chọn có border đậm hoặc dấu check.
- Không dùng flag nếu không cần, tránh nhầm ngôn ngữ với quốc gia.

---

## 13.3 Onboarding Screen

Nên có 3 trang:

```text
1. Discover Korean Fashion
2. AI Picks Your Style
3. Shop Faster and Easier
```

Rule:

- Mỗi trang có 1 ảnh minh họa lớn.
- Title ngắn.
- Description tối đa 2 dòng.
- Có nút Skip và Continue/Get Started.

---

## 13.4 Login Screen

Vì là app demo:

```text
Email
Password
Login
Continue as Demo User
```

Rule:

- Form đơn giản.
- Không cần forgot password thật.
- Social login chỉ để UI hoặc không làm.
- Có thông báo lỗi nhẹ nếu input không hợp lệ.

---

## 13.5 Style Preference Screen

Đây là màn giúp tạo dữ liệu cho AI recommendation.

Cấu trúc:

```text
What style do you like?
[Minimal] [Casual] [Streetwear] [Office] [Korean Style]

What items are you interested in?
[Tops] [Pants] [Dress] [Shoes] [Bags]

Preferred price range
[Budget] [Medium] [Premium]

Save and Continue
```

Rule:

- Dùng selectable chips.
- Cho phép chọn nhiều style/category.
- Nút Continue chỉ active khi user chọn đủ dữ liệu cơ bản.
- Có thể cho nút Skip, nhưng nên khuyến khích chọn.

---

## 13.6 Home Screen

Cấu trúc đề xuất:

```text
Header
Search Bar
Main Banner
Category Chips
AI Picks for You
Trending in Korea
Discount Today
```

Rule:

- Home không quá dài.
- Mỗi section chỉ hiển thị 4–6 sản phẩm.
- Có nút View All nếu muốn xem thêm.
- AI Picks nên nằm cao trên màn hình để nổi bật.

---

## 13.7 Product List / Search Screen

Cấu trúc:

```text
Search Bar
Filter / Sort Row
Product Grid 2 columns
```

Rule:

- Khi không có kết quả, hiển thị empty state thân thiện.
- Filter nên dùng bottom sheet.
- Sort nên dùng simple dropdown hoặc bottom sheet.

Empty state:

```text
No products found
Try another keyword or category
```

---

## 13.8 Product Detail Screen

Cấu trúc:

```text
Large image carousel
Product name
Brand
Price
Rating
AI Reason Card, nếu là sản phẩm đề xuất
Size selector
Color selector
Description
Recommended similar products
Bottom Add to Cart bar
```

Rule:

- Ảnh sản phẩm chiếm phần lớn đầu màn hình.
- Add to Cart button nên cố định dưới màn hình.
- Wishlist icon ở góc phải trên.
- Mô tả không quá dài.

---

## 13.9 AI Picks Screen

Mục tiêu:

- Giải thích app có AI recommendation.
- Hiển thị sản phẩm phù hợp với gu user.

Cấu trúc:

```text
AI Picks for You
Based on your style profile and liked products
[Preference summary]
[Recommended product list]
```

Rule:

- Luôn có text giải thích ngắn.
- Có thể có button “Refresh Recommendations”.
- Product card nên có badge “AI PICK”.

---

## 13.10 Cart Screen

Cấu trúc:

```text
Cart items
Voucher demo, optional
Order summary
Checkout button
```

Rule:

- Nếu cart empty, hiển thị empty state.
- Không bắt user đăng nhập lại.
- Checkout button cố định dưới màn hình.

---

## 13.11 Checkout Screen

Cấu trúc:

```text
Shipping Address
Payment Method
Order Summary
Pay Now
```

Payment methods demo:

```text
Credit Card Demo
KakaoPay Demo
Bank Transfer Demo
Cash on Delivery
```

Rule:

- Không yêu cầu nhập thẻ thật.
- Payment method có radio/check icon.
- Pay Now rõ ràng, dễ bấm.

---

## 13.12 Profile Screen

Cấu trúc:

```text
User info
Style Preferences
Wishlist
Order History
Language
Settings
Logout
```

Rule:

- Profile không cần quá nhiều chức năng.
- Language có thể mở bottom sheet đổi ngôn ngữ.
- Style Preferences cho phép chỉnh lại sở thích.

---

## 14. Navigation rules

Dùng bottom navigation gồm 5 tab:

```text
Home
Search
AI Picks
Cart
Profile
```

Rule:

- Bottom navigation luôn hiển thị ở main flow.
- Không hiển thị bottom navigation ở:
  - Splash
  - Onboarding
  - Login
  - Product Detail, optional
  - Checkout
  - Payment Result
- Product Detail mở bằng push navigation.
- Checkout mở từ Cart.
- Payment Result mở sau Checkout.

---

## 15. Animation rules

Animation cần nhẹ, không làm app nặng.

Nên dùng:

- Fade in khi load product list.
- Small scale khi bấm product card.
- Smooth transition khi đổi tab.
- Loading shimmer nhẹ cho product image.

Không nên dùng:

- Animation quá nhiều trên Home.
- 3D effect phức tạp.
- Motion làm chậm thao tác mua hàng.

Thời lượng animation:

```text
Fast: 150ms
Normal: 250ms
Slow: 350ms
```

---

## 16. Loading / Empty / Error states

Mỗi màn có dữ liệu cần đủ 3 state:

```text
Loading
Empty
Error
```

### Loading

- Product grid: shimmer card hoặc skeleton.
- Button loading: spinner nhỏ.
- Payment: full-screen loading ngắn.

### Empty

Ví dụ:

```text
Your cart is empty
Start exploring Korean fashion now
```

### Error

Vì app demo local data, error ít xuất hiện. Nhưng vẫn nên có:

```text
Something went wrong
Please try again
```

---

## 17. Accessibility rules

- Text không nhỏ hơn 11sp.
- Button height tối thiểu 44px.
- Icon button touch area tối thiểu 44x44.
- Màu text phải đủ tương phản với background.
- Không chỉ dùng màu để thể hiện trạng thái, nên có icon/text đi kèm.
- Product image cần semantic label nếu có thể.

---

## 18. Responsive rules

App ưu tiên mobile portrait.

Hỗ trợ layout:

```text
Small phone: 360px width
Normal phone: 390–430px width
Large phone: 430px+
```

Rule:

- Product grid: 2 cột trên phone.
- Tablet, nếu cần: 3–4 cột.
- Không hardcode chiều rộng màn hình.
- Dùng `MediaQuery`, `LayoutBuilder`, `SliverGridDelegateWithFixedCrossAxisCount`.

---

## 19. Flutter implementation rules

### 19.1 Theme

Toàn bộ màu, text style, radius, spacing nên gom vào theme/token file.

Gợi ý cấu trúc:

```text
lib/app/theme/app_colors.dart
lib/app/theme/app_text_styles.dart
lib/app/theme/app_spacing.dart
lib/app/theme/app_radius.dart
lib/app/theme/app_theme.dart
```

Không viết trực tiếp:

```dart
Color(0xFFE8B4B8)
EdgeInsets.all(16)
BorderRadius.circular(16)
```

ở quá nhiều nơi.

Nên dùng:

```dart
AppColors.accent
AppSpacing.md
AppRadius.large
```

---

## 19.2 State management

Dự án nhỏ nên dùng Cubit/Bloc đơn giản.

Cubit đề xuất:

```text
LanguageCubit
AuthCubit
ProductCubit
CartCubit
WishlistCubit
RecommendationCubit
CheckoutCubit
```

Rule:

- UI không xử lý logic recommendation trực tiếp.
- Logic recommendation nằm trong repository/service/cubit.
- Cart state tách riêng.
- Wishlist state tách riêng.

---

## 19.3 Data source

Vì là demo, dùng local mock data.

```text
assets/data/products.json
assets/data/categories.json
```

Rule:

- Không cần backend thật.
- Product có đủ field để filter/recommendation.
- Image có thể dùng local assets hoặc URL demo ổn định.

---

## 19.4 Payment demo

Thanh toán chỉ là fake result.

Rule:

- Không nhập thông tin thẻ thật.
- Không gọi payment SDK thật.
- Sau khi bấm Pay Now:

```text
Show loading
Wait short duration
Return success result
Create fake order
Clear cart
Navigate to success screen
```

---

## 20. AI recommendation demo rules

AI trong demo không cần gọi model thật. Có thể dùng rule-based scoring để mô phỏng.

### Input

```text
User favorite styles
User favorite categories
User price preference
Liked products
Viewed products
Cart history
Trending products
Sale products
```

### Score rule

```text
+3 nếu style sản phẩm trùng style user thích
+2 nếu category trùng category user thích
+2 nếu sản phẩm đang trending
+1 nếu sản phẩm đang sale
+3 nếu tương tự sản phẩm user đã like
+1 nếu cùng mức giá user thích
```

### Output

Hiển thị sản phẩm điểm cao nhất trong:

```text
AI Picks for You
```

### AI explanation

Mỗi sản phẩm AI nên có lý do ngắn:

Vietnamese:

```text
Được gợi ý vì bạn thích phong cách tối giản Hàn Quốc và thường xem các sản phẩm áo.
```

English:

```text
Recommended because you like Korean minimal style and often view tops.
```

Korean:

```text
미니멀한 한국 스타일을 선호하고 상의 상품을 자주 확인하여 추천합니다.
```

---

## 21. Content tone rules

Ngôn ngữ trong app cần:

- Ngắn gọn.
- Thân thiện.
- Không quá kỹ thuật.
- Tạo cảm giác cá nhân hóa.

Ví dụ nên dùng:

```text
AI Picks for You
Find your style
Recommended for your taste
Trending in Korea
Sale Today
```

Không nên dùng:

```text
Algorithmic product recommendation result
User behavior model analysis completed
Personalized inference data
```

---

## 22. Badge rules

Các badge được phép dùng:

```text
AI PICK
SALE
NEW
HOT
TRENDING
```

Style:

```text
Height: 22–26
Radius: pill
Font: 10–11sp Medium
Padding horizontal: 8–10
```

Color:

```text
AI PICK: Purple background
SALE: Red background
NEW: Black background
HOT/TRENDING: Accent or warm color
```

Rule:

- Mỗi product card tối đa 2 badge.
- Không để badge che mặt sản phẩm quá nhiều.

---

## 23. Form rules

Text field style:

```text
Height: 52
Radius: 14–16
Background: #F5F5F5 hoặc #FFFFFF
Border: #EEEEEE
Focused border: #111111
Error border: #E53935
```

Rule:

- Label rõ ràng.
- Error text ngắn.
- Password có icon show/hide.
- Không yêu cầu form phức tạp trong demo.

---

## 24. Demo presentation rules

Khi build app để thuyết trình, cần đảm bảo:

- App có dữ liệu mẫu đẹp.
- Không có màn hình trắng/lỗi khi không có internet.
- Thanh toán luôn thành công hoặc có option demo success.
- AI recommendation luôn có sản phẩm để hiển thị.
- Ngôn ngữ Hàn Quốc hiển thị đúng font, không lỗi ký tự.
- Cart, wishlist, order history hoạt động ổn định trong local session.

Luồng demo đề xuất:

```text
1. Mở app
2. Chọn 한국어
3. Login bằng Demo User
4. Chọn style: Korean Minimal, Casual
5. Home hiển thị AI Picks
6. Mở sản phẩm được AI gợi ý
7. Xem lý do AI recommend
8. Add to Cart
9. Checkout
10. Fake Payment Success
11. Xem Order History
```

---

## 25. Definition of Done cho UI

Một màn hình được xem là hoàn thành khi:

- Đúng layout theo design rules.
- Không hardcode text.
- Hỗ trợ 3 ngôn ngữ.
- Có loading/empty/error state nếu cần.
- Không overflow text ở tiếng Việt hoặc tiếng Hàn.
- Button và icon có touch area đủ lớn.
- Màu sắc dùng từ design system.
- Spacing/radius dùng token chung.
- Chạy tốt trên màn hình nhỏ và màn hình lớn.

---

## 26. Checklist trước khi nộp demo

```text
[x] Splash screen hoàn chỉnh
[x] Chọn ngôn ngữ hoạt động
[x] App đổi được Việt / Hàn / Anh
[x] Login demo hoạt động
[x] Style preference lưu được
[x] Home có banner, category, AI Picks, Trending, Sale
[x] Search/filter hoạt động
[x] Product detail đầy đủ thông tin
[x] Wishlist hoạt động
[x] Cart thêm/xóa/tăng giảm số lượng hoạt động
[x] Checkout hoạt động
[x] Fake payment success hoạt động
[x] Order history có đơn hàng sau thanh toán
[x] Profile có đổi ngôn ngữ và xem preference
[x] Không có text overflow
[x] Không có crash khi back navigation
[x] UI đồng nhất màu, font, radius, spacing
```

---

## 27. Kết luận

Design của app cần tập trung vào sự đơn giản, hiện đại và có cảm giác thời trang Hàn Quốc.  
Vì đây là app demo đại học, ưu tiên quan trọng nhất là:

```text
Giao diện đẹp
Luồng mua hàng rõ ràng
Đa ngôn ngữ ổn định
AI recommendation mô phỏng hợp lý
Thanh toán fake mượt
Code Flutter dễ bảo trì
```

Không cần làm quá nhiều chức năng thật. Một bản demo nhỏ nhưng hoàn chỉnh, mượt và có câu chuyện AI rõ ràng sẽ thuyết phục hơn một app nhiều chức năng nhưng rối và thiếu ổn định.
