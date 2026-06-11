import 'package:equatable/equatable.dart';
import '../service/recommendation_service.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object?> get props => [];
}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final List<RecommendedProduct> recommendedProducts;

  const RecommendationLoaded(this.recommendedProducts);

  @override
  List<Object?> get props => [recommendedProducts];
}

class RecommendationError extends RecommendationState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
