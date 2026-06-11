// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'SeoulStyle AI';

  @override
  String get discoverKoreanFashion => 'Khám phá Thời trang Hàn Quốc';

  @override
  String get discoverKoreanFashionDesc =>
      'Khám phá các xu hướng thời trang được tuyển chọn trực tiếp từ Seoul.';

  @override
  String get aiPicksYourStyle => 'AI Gợi ý Phong cách của Bạn';

  @override
  String get aiPicksYourStyleDesc =>
      'Nhận các gợi ý thời trang cá nhân hóa phù hợp với sở thích của bạn.';

  @override
  String get shopFasterEasier => 'Mua sắm Nhanh chóng & Dễ dàng';

  @override
  String get shopFasterEasierDesc =>
      'Trải nghiệm mua sắm mượt mà cùng tính năng thanh toán mô phỏng.';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ của bạn';

  @override
  String get tiengViet => 'Tiếng Việt';

  @override
  String get hanQuoc => '한국어';

  @override
  String get tiengAnh => 'English';

  @override
  String get continueBtn => 'Tiếp tục';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get getStarted => 'Bắt đầu ngay';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get loginSubtitle =>
      'Đăng nhập để xem danh sách gợi ý thời trang dành riêng cho bạn';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get login => 'Đăng nhập';

  @override
  String get continueAsGuest => 'Dùng tài khoản Demo';

  @override
  String get or => 'hoặc';

  @override
  String get emailError => 'Vui lòng nhập email hợp lệ';

  @override
  String get passwordError => 'Mật khẩu phải chứa ít nhất 6 ký tự';

  @override
  String get stylePrefTitle => 'Bạn thích phong cách nào?';

  @override
  String get stylePrefSubtitle =>
      'Chọn các phong cách phù hợp với trang phục hàng ngày của bạn';

  @override
  String get itemsPrefTitle => 'Bạn quan tâm sản phẩm nào?';

  @override
  String get pricePrefTitle => 'Mức giá mong muốn';

  @override
  String get saveAndContinue => 'Lưu và Tiếp tục';

  @override
  String get homeTitle => 'Tìm kiếm phong cách';

  @override
  String homeGreeting(String name) {
    return 'Xin chào, $name 👋';
  }

  @override
  String get searchHint => 'Tìm sản phẩm...';

  @override
  String get aiPicksForYou => 'AI gợi ý cho bạn';

  @override
  String get trendingInKorea => 'Thịnh hành tại Hàn Quốc';

  @override
  String get discountToday => 'Khuyến mãi hôm nay';

  @override
  String get viewAll => 'Xem tất cả';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get filter => 'Bộ lọc';

  @override
  String get sort => 'Sắp xếp';

  @override
  String productsFound(int count) {
    return 'Tìm thấy $count sản phẩm';
  }

  @override
  String get noProductsFound => 'Không tìm thấy sản phẩm';

  @override
  String get tryAnotherKeyword => 'Thử tìm kiếm với từ khóa hoặc danh mục khác';

  @override
  String get productDetail => 'Chi tiết sản phẩm';

  @override
  String get addToCart => 'Thêm vào giỏ hàng';

  @override
  String get addedToCart => 'Đã thêm vào giỏ hàng!';

  @override
  String get viewCart => 'Xem giỏ hàng';

  @override
  String get size => 'Kích thước';

  @override
  String get color => 'Màu sắc';

  @override
  String get description => 'Mô tả';

  @override
  String get similarProducts => 'Sản phẩm tương tự';

  @override
  String aiReasonStyleMatch(String style) {
    return 'Được gợi ý vì bạn thích phong cách $style.';
  }

  @override
  String get aiReasonTrending => 'Sản phẩm này hiện đang rất hot ở Hàn Quốc.';

  @override
  String get aiReasonSale => 'Đang được ưu đãi giảm giá hôm nay.';

  @override
  String get aiReasonDefault => 'Được tuyển chọn riêng cho phong cách của bạn.';

  @override
  String get myCart => 'Giỏ hàng';

  @override
  String get cartEmpty => 'Giỏ hàng trống';

  @override
  String get exploreFashionNow =>
      'Khám phá các sản phẩm thời trang Hàn Quốc ngay thôi';

  @override
  String get subtotal => 'Tạm tính';

  @override
  String get discount => 'Giảm giá';

  @override
  String get shippingFee => 'Phí vận chuyển';

  @override
  String get total => 'Tổng tiền';

  @override
  String get checkout => 'Thanh toán';

  @override
  String get shippingAddress => 'Địa chỉ giao hàng';

  @override
  String get paymentMethod => 'Phương thức thanh toán';

  @override
  String get payNow => 'Thanh toán ngay';

  @override
  String get processingPayment => 'Đang xử lý giao dịch...';

  @override
  String get paymentSuccessful => 'Thanh toán thành công!';

  @override
  String orderId(String id) {
    return 'Mã đơn hàng: $id';
  }

  @override
  String get estimatedDelivery => 'Thời gian giao hàng dự kiến: 3–5 ngày';

  @override
  String get viewOrderDetails => 'Xem lịch sử đơn hàng';

  @override
  String get backToHome => 'Về Trang chủ';

  @override
  String get myOrders => 'Đơn hàng của tôi';

  @override
  String get orderStatusProcessing => 'Đang xử lý';

  @override
  String get orderStatusDelivered => 'Đã giao hàng';

  @override
  String get noOrdersYet => 'Chưa có đơn hàng nào';

  @override
  String get timeToShop => 'Đã đến lúc sắm ngay các món đồ bạn yêu thích!';

  @override
  String get profile => 'Tài khoản';

  @override
  String get myShopping => 'Mua sắm';

  @override
  String get preferences => 'Sở thích';

  @override
  String get stylePreferences => 'Phong cách yêu thích';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get logoutConfirm => 'Bạn có chắc chắn muốn đăng xuất?';

  @override
  String get cancel => 'Hủy bỏ';

  @override
  String get appVersion => 'SeoulStyle AI v1.0.0 — Bản Demo';

  @override
  String get comingSoon => 'Tính năng đang được phát triển!';

  @override
  String get priceBudget => 'Giá rẻ';

  @override
  String get priceMedium => 'Trung bình';

  @override
  String get pricePremium => 'Cao cấp';

  @override
  String get aiPicksTitle => 'Gợi ý của AI';

  @override
  String get aiPicksSubtitle => 'Dựa trên phong cách của bạn';

  @override
  String get wishlistTitle => 'Danh sách yêu thích';

  @override
  String get wishlistEmpty => 'Danh sách trống';

  @override
  String get profileTitle => 'Tài khoản';

  @override
  String get homeLabel => 'Trang chủ';

  @override
  String get searchLabel => 'Tìm kiếm';

  @override
  String get aiPicksLabel => 'Gợi ý AI';

  @override
  String get cartLabel => 'Giỏ hàng';

  @override
  String get profileLabel => 'Tài khoản';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get categories => 'Danh mục';

  @override
  String get budget => 'Ngân sách';

  @override
  String get stylePrefRequired => 'Yêu cầu Hồ sơ Phong cách';

  @override
  String get stylePrefRequiredDesc =>
      'Thiết lập hồ sơ phong cách của bạn để kích hoạt gợi ý thời trang cá nhân hóa từ AI.';

  @override
  String get setupStyleProfile => 'Thiết lập Hồ sơ';

  @override
  String get wishlistEmptyDesc =>
      'Nhấn vào biểu tượng trái tim trên bất kỳ sản phẩm nào để lưu vào danh sách yêu thích.';

  @override
  String get exploreProducts => 'Khám phá Sản phẩm';

  @override
  String get appSection => 'Ứng dụng';

  @override
  String get aboutApp => 'Giới thiệu SeoulStyle AI';

  @override
  String get aboutDesc =>
      'SeoulStyle AI là bản demo ứng dụng mua sắm thời trang cao cấp của Hàn Quốc được thiết kế để phục vụ cho các bài thuyết trình/tốt nghiệp đại học.\n\nTính năng chính:\n• Phong cách thẩm mỹ tối giản, cao cấp kiểu Hàn Quốc\n• Thuật toán cá nhân hóa AI giả lập theo luật\n• Hỗ trợ đa ngôn ngữ (Anh / Việt / Hàn)\n• Thiết kế offline-first lưu trữ dữ liệu giả lập qua SharedPreferences / JSON local';

  @override
  String get close => 'Đóng';
}
