import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SeoulStyle AI'**
  String get appName;

  /// No description provided for @discoverKoreanFashion.
  ///
  /// In en, this message translates to:
  /// **'Discover Korean Fashion'**
  String get discoverKoreanFashion;

  /// No description provided for @discoverKoreanFashionDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore handpicked style trends straight from the heart of Seoul.'**
  String get discoverKoreanFashionDesc;

  /// No description provided for @aiPicksYourStyle.
  ///
  /// In en, this message translates to:
  /// **'AI Picks Your Style'**
  String get aiPicksYourStyle;

  /// No description provided for @aiPicksYourStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Get personalized style recommendations tailored to your taste profile.'**
  String get aiPicksYourStyleDesc;

  /// No description provided for @shopFasterEasier.
  ///
  /// In en, this message translates to:
  /// **'Shop Faster & Easier'**
  String get shopFasterEasier;

  /// No description provided for @shopFasterEasierDesc.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a seamless local shopping experience with simulated payment.'**
  String get shopFasterEasierDesc;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @tiengViet.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get tiengViet;

  /// No description provided for @hanQuoc.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get hanQuoc;

  /// No description provided for @tiengAnh.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get tiengAnh;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your personalized fashion feed'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Demo User'**
  String get continueAsGuest;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailError;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordError;

  /// No description provided for @stylePrefTitle.
  ///
  /// In en, this message translates to:
  /// **'What style do you like?'**
  String get stylePrefTitle;

  /// No description provided for @stylePrefSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select styles that match your everyday look'**
  String get stylePrefSubtitle;

  /// No description provided for @itemsPrefTitle.
  ///
  /// In en, this message translates to:
  /// **'What items are you interested in?'**
  String get itemsPrefTitle;

  /// No description provided for @pricePrefTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferred price range'**
  String get pricePrefTitle;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save and Continue'**
  String get saveAndContinue;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Find your style'**
  String get homeTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name} 👋'**
  String homeGreeting(String name);

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchHint;

  /// No description provided for @aiPicksForYou.
  ///
  /// In en, this message translates to:
  /// **'AI Picks for You'**
  String get aiPicksForYou;

  /// No description provided for @trendingInKorea.
  ///
  /// In en, this message translates to:
  /// **'Trending in Korea'**
  String get trendingInKorea;

  /// No description provided for @discountToday.
  ///
  /// In en, this message translates to:
  /// **'Discount Today'**
  String get discountToday;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @productsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} products found'**
  String productsFound(int count);

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @tryAnotherKeyword.
  ///
  /// In en, this message translates to:
  /// **'Try another keyword or category'**
  String get tryAnotherKeyword;

  /// No description provided for @productDetail.
  ///
  /// In en, this message translates to:
  /// **'Product Detail'**
  String get productDetail;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart!'**
  String get addedToCart;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @similarProducts.
  ///
  /// In en, this message translates to:
  /// **'Similar Products'**
  String get similarProducts;

  /// No description provided for @aiReasonStyleMatch.
  ///
  /// In en, this message translates to:
  /// **'Matches your interest in {style} style.'**
  String aiReasonStyleMatch(String style);

  /// No description provided for @aiReasonTrending.
  ///
  /// In en, this message translates to:
  /// **'This item is currently trending in Korea.'**
  String get aiReasonTrending;

  /// No description provided for @aiReasonSale.
  ///
  /// In en, this message translates to:
  /// **'On sale today with a special discount.'**
  String get aiReasonSale;

  /// No description provided for @aiReasonDefault.
  ///
  /// In en, this message translates to:
  /// **'Handpicked for your style profile.'**
  String get aiReasonDefault;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @exploreFashionNow.
  ///
  /// In en, this message translates to:
  /// **'Start exploring Korean fashion now'**
  String get exploreFashionNow;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @shippingFee.
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shippingFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @processingPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing payment...'**
  String get processingPayment;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccessful;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID: {id}'**
  String orderId(String id);

  /// No description provided for @estimatedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery: 3–5 days'**
  String get estimatedDelivery;

  /// No description provided for @viewOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'View Order History'**
  String get viewOrderDetails;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @orderStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderStatusProcessing;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrdersYet;

  /// No description provided for @timeToShop.
  ///
  /// In en, this message translates to:
  /// **'Time to shop for your favorite items!'**
  String get timeToShop;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myShopping.
  ///
  /// In en, this message translates to:
  /// **'My Shopping'**
  String get myShopping;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @stylePreferences.
  ///
  /// In en, this message translates to:
  /// **'Style Preferences'**
  String get stylePreferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'SeoulStyle AI v1.0.0 — Demo'**
  String get appVersion;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Feature coming soon!'**
  String get comingSoon;

  /// No description provided for @priceBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get priceBudget;

  /// No description provided for @priceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priceMedium;

  /// No description provided for @pricePremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get pricePremium;

  /// No description provided for @aiPicksTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Picks for You'**
  String get aiPicksTitle;

  /// No description provided for @aiPicksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your style profile'**
  String get aiPicksSubtitle;

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistTitle;

  /// No description provided for @wishlistEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved items yet'**
  String get wishlistEmpty;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @homeLabel.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeLabel;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// No description provided for @aiPicksLabel.
  ///
  /// In en, this message translates to:
  /// **'AI Picks'**
  String get aiPicksLabel;

  /// No description provided for @cartLabel.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartLabel;

  /// No description provided for @profileLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLabel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @stylePrefRequired.
  ///
  /// In en, this message translates to:
  /// **'Style Profile Required'**
  String get stylePrefRequired;

  /// No description provided for @stylePrefRequiredDesc.
  ///
  /// In en, this message translates to:
  /// **'Set up your style profile to enable personalized AI fashion recommendations.'**
  String get stylePrefRequiredDesc;

  /// No description provided for @setupStyleProfile.
  ///
  /// In en, this message translates to:
  /// **'Setup Style Profile'**
  String get setupStyleProfile;

  /// No description provided for @wishlistEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on any product to save it to your wishlist.'**
  String get wishlistEmptyDesc;

  /// No description provided for @exploreProducts.
  ///
  /// In en, this message translates to:
  /// **'Explore Products'**
  String get exploreProducts;

  /// No description provided for @appSection.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get appSection;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About SeoulStyle AI'**
  String get aboutApp;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'SeoulStyle AI is a high-fidelity fashion shopping application demonstration designed for university graduation/presentation.\n\nKey features:\n• Korean-style premium minimal aesthetics\n• Rule-based mock AI personalization algorithm\n• Multi-language localization (EN / VI / KO)\n• Offline-first design with local SQLite / SharedPreferences mock repositories'**
  String get aboutDesc;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
