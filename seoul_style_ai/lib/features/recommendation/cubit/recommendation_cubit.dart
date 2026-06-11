import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product.dart';
import '../../../data/models/user_preference.dart';
import '../service/recommendation_service.dart';
import 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit() : super(RecommendationInitial());

  void generateRecommendations({
    required UserPreference preference,
    required List<Product> allProducts,
  }) {
    emit(RecommendationLoading());
    try {
      final List<RecommendedProduct> scoredProducts = [];

      for (final product in allProducts) {
        final rec = RecommendationService.buildRecommendation(product, preference);
        scoredProducts.add(rec);
      }

      // Sort by score descending (highest score first)
      scoredProducts.sort((a, b) => b.score.compareTo(a.score));

      // Limit to top 12 products
      final topPicks = scoredProducts.take(12).toList();
      emit(RecommendationLoaded(topPicks));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }
}
