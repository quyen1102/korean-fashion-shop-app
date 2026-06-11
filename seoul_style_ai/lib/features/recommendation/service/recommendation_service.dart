import '../../../data/models/product.dart';
import '../../../data/models/user_preference.dart';

class RecommendedProduct {
  final Product product;
  final int score;
  final String reasonKey;
  final String? reasonParam; // Dynamic parameter like style name or category name

  const RecommendedProduct({
    required this.product,
    required this.score,
    required this.reasonKey,
    this.reasonParam,
  });
}

class RecommendationService {
  RecommendationService._();

  static int calculateScore(Product product, UserPreference preference) {
    int score = 0;
    final lowercasedStyles = preference.favoriteStyles.map((s) => s.toLowerCase()).toSet();
    final lowercasedCategories = preference.favoriteCategories.map((c) => c.toLowerCase()).toSet();

    // 1. Style tag matching (+3 per matching style tag)
    for (final tag in product.styleTags) {
      if (lowercasedStyles.contains(tag.toLowerCase())) {
        score += 3;
      }
    }

    // 2. Category matching (+2)
    if (lowercasedCategories.contains(product.category.toLowerCase())) {
      score += 2;
    }

    // 3. Trending item (+2)
    if (product.isTrending) {
      score += 2;
    }

    // 4. Sale item (+1)
    if (product.isSale) {
      score += 1;
    }

    // 5. Price preference matching (+1)
    if (product.priceLevel.toLowerCase() == preference.pricePreference.toLowerCase()) {
      score += 1;
    }

    return score;
  }

  static RecommendedProduct buildRecommendation(Product product, UserPreference preference) {
    final score = calculateScore(product, preference);

    // Determine the dominant reason for recommendation
    String reasonKey = 'aiReasonDefault';
    String? reasonParam;

    // Check matches in order of strength
    String? matchingStyle;
    final lowercasedStyles = preference.favoriteStyles.map((s) => s.toLowerCase()).toSet();
    for (final tag in product.styleTags) {
      if (lowercasedStyles.contains(tag.toLowerCase())) {
        matchingStyle = tag;
        break;
      }
    }

    if (matchingStyle != null) {
      reasonKey = 'aiReasonStyleMatch';
      reasonParam = matchingStyle;
    } else if (product.isTrending) {
      reasonKey = 'aiReasonTrending';
    } else if (product.isSale) {
      reasonKey = 'aiReasonSale';
    }

    return RecommendedProduct(
      product: product,
      score: score,
      reasonKey: reasonKey,
      reasonParam: reasonParam,
    );
  }
}
