import 'package:seoul_style_ai/data/models/product.dart';
import 'package:seoul_style_ai/data/models/user_preference.dart';
import 'package:seoul_style_ai/features/recommendation/service/recommendation_service.dart';

void main() {
  print('Running Recommendation scoring pure Dart tests...');

  const defaultProduct = Product(
    id: 'test-1',
    name: 'Test Product',
    brand: 'Test Brand',
    category: 'tops',
    price: 10.0,
    originalPrice: 10.0,
    discountPercent: 0,
    rating: 4.5,
    reviewCount: 10,
    imageUrls: ['image.png'],
    sizes: ['S'],
    colors: ['White'],
    styleTags: ['minimal'],
    priceLevel: 'medium',
    isTrending: false,
    isNew: false,
    isSale: false,
    description: 'Test Description',
  );

  // Test 1: Score is 0 when nothing matches
  {
    const preference = UserPreference(
      favoriteStyles: ['streetwear'],
      favoriteCategories: ['shoes'],
      pricePreference: 'budget',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final score = RecommendationService.calculateScore(defaultProduct, preference);
    assert(score == 0, 'Test 1 Failed: expected 0, got $score');
    print('✓ Test 1: No match = 0 score passed');
  }

  // Test 2: Style tag match adds +3
  {
    const preference = UserPreference(
      favoriteStyles: ['minimal'],
      favoriteCategories: ['shoes'],
      pricePreference: 'budget',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final score = RecommendationService.calculateScore(defaultProduct, preference);
    assert(score == 3, 'Test 2 Failed: expected 3, got $score');
    print('✓ Test 2: Style match (+3) passed');
  }

  // Test 3: Category match adds +2
  {
    const preference = UserPreference(
      favoriteStyles: ['streetwear'],
      favoriteCategories: ['tops'],
      pricePreference: 'budget',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final score = RecommendationService.calculateScore(defaultProduct, preference);
    assert(score == 2, 'Test 3 Failed: expected 2, got $score');
    print('✓ Test 3: Category match (+2) passed');
  }

  // Test 4: Trending item adds +2
  {
    const trendingProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      brand: 'Test Brand',
      category: 'tops',
      price: 10.0,
      originalPrice: 10.0,
      discountPercent: 0,
      rating: 4.5,
      reviewCount: 10,
      imageUrls: ['image.png'],
      sizes: ['S'],
      colors: ['White'],
      styleTags: ['minimal'],
      priceLevel: 'medium',
      isTrending: true,
      isNew: false,
      isSale: false,
      description: 'Test Description',
    );
    const preference = UserPreference(
      favoriteStyles: ['streetwear'],
      favoriteCategories: ['shoes'],
      pricePreference: 'budget',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final score = RecommendationService.calculateScore(trendingProduct, preference);
    assert(score == 2, 'Test 4 Failed: expected 2, got $score');
    print('✓ Test 4: Trending match (+2) passed');
  }

  // Test 5: Multiple attributes add up correctly
  {
    const customProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      brand: 'Test Brand',
      category: 'tops',
      price: 10.0,
      originalPrice: 15.0,
      discountPercent: 33,
      rating: 4.5,
      reviewCount: 10,
      imageUrls: ['image.png'],
      sizes: ['S'],
      colors: ['White'],
      styleTags: ['minimal', 'korean'],
      priceLevel: 'medium',
      isTrending: true,
      isNew: false,
      isSale: true,
      description: 'Test Description',
    );
    const preference = UserPreference(
      favoriteStyles: ['minimal', 'korean'],
      favoriteCategories: ['tops'],
      pricePreference: 'medium',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final score = RecommendationService.calculateScore(customProduct, preference);
    assert(score == 12, 'Test 5 Failed: expected 12, got $score');
    print('✓ Test 5: Complex match (6+2+2+1+1=12) passed');
  }

  // Test 6: Recommendation builds correct reason
  {
    const preference = UserPreference(
      favoriteStyles: ['minimal'],
      favoriteCategories: ['tops'],
      pricePreference: 'medium',
      viewedProductIds: [],
      likedProductIds: [],
    );
    final rec = RecommendationService.buildRecommendation(defaultProduct, preference);
    assert(rec.reasonKey == 'aiReasonStyleMatch', 'Test 6 Failed: expected aiReasonStyleMatch, got ${rec.reasonKey}');
    assert(rec.reasonParam == 'minimal', 'Test 6 Failed: expected minimal, got ${rec.reasonParam}');
    print('✓ Test 6: Dominant reason resolution passed');
  }

  print('All pure Dart tests passed successfully! 🎉');
}
