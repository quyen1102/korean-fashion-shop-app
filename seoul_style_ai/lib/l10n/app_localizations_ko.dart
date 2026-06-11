// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'SeoulStyle AI';

  @override
  String get discoverKoreanFashion => '한국 패션 둘러보기';

  @override
  String get discoverKoreanFashionDesc => '서울의 중심에서 엄선한 최신 패션 트렌드를 확인해보세요.';

  @override
  String get aiPicksYourStyle => 'AI 스타일 맞춤 추천';

  @override
  String get aiPicksYourStyleDesc => '사용자의 취향 프로필을 분석하여 어울리는 스타일을 추천합니다.';

  @override
  String get shopFasterEasier => '더 빠르고 간편한 쇼핑';

  @override
  String get shopFasterEasierDesc => '시뮬레이션 결제 기능으로 간편하고 매끄러운 쇼핑을 경험하세요.';

  @override
  String get chooseLanguage => '언어를 선택해 주세요';

  @override
  String get tiengViet => 'Tiếng Việt';

  @override
  String get hanQuoc => '한국어';

  @override
  String get tiengAnh => 'English';

  @override
  String get continueBtn => '계속하기';

  @override
  String get skip => '건너뛰기';

  @override
  String get getStarted => '시작하기';

  @override
  String get welcomeBack => '다시 만나서 반가워요';

  @override
  String get loginSubtitle => '로그인하고 개인화된 패션 피드를 만나보세요';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get login => '로그인';

  @override
  String get continueAsGuest => '데모 계정으로 계속하기';

  @override
  String get or => '또는';

  @override
  String get emailError => '올바른 이메일 주소를 입력해주세요';

  @override
  String get passwordError => '비밀번호는 6자 이상이어야 합니다';

  @override
  String get stylePrefTitle => '어떤 스타일을 선호하시나요?';

  @override
  String get stylePrefSubtitle => '데일리 룩에 잘 맞는 스타일을 선택해주세요';

  @override
  String get itemsPrefTitle => '관심 있는 아이템은 무엇인가요?';

  @override
  String get pricePrefTitle => '선호하는 가격대';

  @override
  String get saveAndContinue => '저장 후 계속하기';

  @override
  String get homeTitle => '스타일 찾기';

  @override
  String homeGreeting(String name) {
    return '안녕하세요, $name 님 👋';
  }

  @override
  String get searchHint => '상품을 검색해보세요...';

  @override
  String get aiPicksForYou => 'AI 추천 상품';

  @override
  String get trendingInKorea => '한국 인기 트렌드';

  @override
  String get discountToday => '오늘의 특가 상품';

  @override
  String get viewAll => '전체보기';

  @override
  String get search => '검색';

  @override
  String get filter => '필터';

  @override
  String get sort => '정렬';

  @override
  String productsFound(int count) {
    return '$count개의 상품이 있습니다';
  }

  @override
  String get noProductsFound => '검색 결과가 없습니다';

  @override
  String get tryAnotherKeyword => '다른 키워드나 카테고리로 검색해보세요';

  @override
  String get productDetail => '상품 상세정보';

  @override
  String get addToCart => '장바구니 담기';

  @override
  String get addedToCart => '장바구니에 추가되었습니다!';

  @override
  String get viewCart => '장바구니 보기';

  @override
  String get size => '사이즈';

  @override
  String get color => '색상';

  @override
  String get description => '설명';

  @override
  String get similarProducts => '유사한 추천 상품';

  @override
  String aiReasonStyleMatch(String style) {
    return '$style 스타일을 선호하여 추천드립니다.';
  }

  @override
  String get aiReasonTrending => '현재 한국에서 인기 있는 핫 아이템입니다.';

  @override
  String get aiReasonSale => '오늘만 제공되는 특별 할인 상품입니다.';

  @override
  String get aiReasonDefault => '회원님의 스타일 프로필을 기반으로 선정되었습니다.';

  @override
  String get myCart => '장바구니';

  @override
  String get cartEmpty => '장바구니가 비어 있습니다';

  @override
  String get exploreFashionNow => '지금 바로 한국 패션 쇼핑을 시작해보세요';

  @override
  String get subtotal => '소계';

  @override
  String get discount => '할인 금액';

  @override
  String get shippingFee => '배송비';

  @override
  String get total => '합계';

  @override
  String get checkout => '주문하기';

  @override
  String get shippingAddress => '배송지 정보';

  @override
  String get paymentMethod => '결제 수단';

  @override
  String get payNow => '결제하기';

  @override
  String get processingPayment => '결제를 진행 중입니다...';

  @override
  String get paymentSuccessful => '결제가 완료되었습니다!';

  @override
  String orderId(String id) {
    return '주문 번호: $id';
  }

  @override
  String get estimatedDelivery => '예상 배송일: 3~5일 소요';

  @override
  String get viewOrderDetails => '주문 내역 보기';

  @override
  String get backToHome => '홈으로 이동';

  @override
  String get myOrders => '내 주문 내역';

  @override
  String get orderStatusProcessing => '배송 준비 중';

  @override
  String get orderStatusDelivered => '배송 완료';

  @override
  String get noOrdersYet => '주문 내역이 없습니다';

  @override
  String get timeToShop => '선호하는 패션 아이템을 주문해보세요!';

  @override
  String get profile => '프로필';

  @override
  String get myShopping => '쇼핑 정보';

  @override
  String get preferences => '설정';

  @override
  String get stylePreferences => '스타일 환경설정';

  @override
  String get language => '언어 설정';

  @override
  String get logout => '로그아웃';

  @override
  String get logoutConfirm => '정말 로그아웃 하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get appVersion => 'SeoulStyle AI v1.0.0 — 데모 버전';

  @override
  String get comingSoon => '준비 중인 기능입니다!';

  @override
  String get priceBudget => '실속형';

  @override
  String get priceMedium => '일반형';

  @override
  String get pricePremium => '고급형';

  @override
  String get aiPicksTitle => 'AI 추천 상품';

  @override
  String get aiPicksSubtitle => '선호하시는 스타일에 기반함';

  @override
  String get wishlistTitle => '위시리스트';

  @override
  String get wishlistEmpty => '저장된 상품이 없습니다';

  @override
  String get profileTitle => '프로필';

  @override
  String get homeLabel => '홈';

  @override
  String get searchLabel => '검색';

  @override
  String get aiPicksLabel => 'AI 추천';

  @override
  String get cartLabel => '장바구니';

  @override
  String get profileLabel => '프로필';

  @override
  String get edit => '편집';

  @override
  String get categories => '카테고리';

  @override
  String get budget => '예산';

  @override
  String get stylePrefRequired => '스타일 프로필 필요';

  @override
  String get stylePrefRequiredDesc => '개인화된 AI 패션 추천을 위해 스타일 프로필을 설정해주세요.';

  @override
  String get setupStyleProfile => '스타일 프로필 설정';

  @override
  String get wishlistEmptyDesc => '상품의 하트 아이콘을 누르면 위시리스트에 저장됩니다.';

  @override
  String get exploreProducts => '상품 둘러보기';

  @override
  String get appSection => '앱 설정';

  @override
  String get aboutApp => 'SeoulStyle AI 정보';

  @override
  String get aboutDesc =>
      'SeoulStyle AI는 대학 졸업/발표를 위해 설계된 한국형 프리미엄 미니멀 패션 쇼핑 애플리케이션 데모입니다.\n\n주요 기능:\n• 한국식 프리미엄 미니멀리즘 디자인\n• 룰 기반 가상 AI 개인화 추천 알고리즘\n• 다국어 현지화 지원 (EN / VI / KO)\n• SharedPreferences 및 로컬 JSON 데이터 기반의 오프라인 우선 설계';

  @override
  String get close => '닫기';
}
