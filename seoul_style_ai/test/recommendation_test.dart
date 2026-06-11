import 'package:flutter_test/flutter_test.dart';
import 'package:seoul_style_ai/data/models/product.dart';
import 'package:seoul_style_ai/data/models/user_preference.dart';
import 'package:seoul_style_ai/features/recommendation/service/recommendation_service.dart';

void main() {
  group('Recommendation Service Scoring Tests', () {
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

    test('Score is 0 when nothing matches', () {
      const preference = UserPreference(
        favoriteStyles: ['streetwear'],
        favoriteCategories: ['shoes'],
        pricePreference: 'budget',
        viewedProductIds: [],
        likedProductIds: [],
      );

      final score = RecommendationService.calculateScore(defaultProduct, preference);
      expect(score, equals(0));
    });

    test('Style tag match adds +3', () {
      const preference = UserPreference(
        favoriteStyles: ['minimal'],
        favoriteCategories: ['shoes'],
        pricePreference: 'budget',
        viewedProductIds: [],
        likedProductIds: [],
      );

      final score = RecommendationService.calculateScore(defaultProduct, preference);
      expect(score, equals(3));
    });

    test('Category match adds +2', () {
      const preference = UserPreference(
        favoriteStyles: ['streetwear'],
        favoriteCategories: ['tops'],
        pricePreference: 'budget',
        viewedProductIds: [],
        likedProductIds: [],
      );

      final score = RecommendationService.calculateScore(defaultProduct, preference);
      expect(score, equals(2));
    });

    test('Trending item adds +2', () {
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
        isTrending: true, // Trending
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
      expect(score, equals(2));
    });

    test('Multiple matching attributes add up correctly', () {
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
        isTrending: true,  // +2
        isNew: false,
        isSale: true,      // +1
        description: 'Test Description',
      );

      const preference = UserPreference(
        favoriteStyles: ['minimal', 'korean'], // matches 2 style tags -> +6
        favoriteCategories: ['tops'],          // matches category -> +2
        pricePreference: 'medium',             // matches price level -> +1
        viewedProductIds: [],
        likedProductIds: [],
      );

      // Total expected: 6 (styles) + 2 (category) + 2 (trending) + 1 (sale) + 1 (price) = 12
      final score = RecommendationService.calculateScore(customProduct, preference);
      expect(score, equals(12));
    });

    test('Recommendation builds correct dominant reason tag', () {
      const preference = UserPreference(
        favoriteStyles: ['minimal'],
        favoriteCategories: ['tops'],
        pricePreference: 'medium',
        viewedProductIds: [],
        likedProductIds: [],
      );

      final rec = RecommendationService.buildRecommendation(defaultProduct, preference);
      expect(rec.reasonKey, equals('aiReasonStyleMatch'));
      expect(rec.reasonParam, equals('minimal'));
    });
  });
}
