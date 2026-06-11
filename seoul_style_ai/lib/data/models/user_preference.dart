import 'package:equatable/equatable.dart';

class UserPreference extends Equatable {
  final List<String> favoriteStyles;
  final List<String> favoriteCategories;
  final String pricePreference;
  final List<String> viewedProductIds;
  final List<String> likedProductIds;

  const UserPreference({
    required this.favoriteStyles,
    required this.favoriteCategories,
    required this.pricePreference,
    required this.viewedProductIds,
    required this.likedProductIds,
  });

  factory UserPreference.empty() {
    return const UserPreference(
      favoriteStyles: [],
      favoriteCategories: [],
      pricePreference: 'medium',
      viewedProductIds: [],
      likedProductIds: [],
    );
  }

  factory UserPreference.fromJson(Map<String, dynamic> json) {
    return UserPreference(
      favoriteStyles: List<String>.from(json['favoriteStyles'] as List? ?? []),
      favoriteCategories: List<String>.from(json['favoriteCategories'] as List? ?? []),
      pricePreference: json['pricePreference'] as String? ?? 'medium',
      viewedProductIds: List<String>.from(json['viewedProductIds'] as List? ?? []),
      likedProductIds: List<String>.from(json['likedProductIds'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favoriteStyles': favoriteStyles,
      'favoriteCategories': favoriteCategories,
      'pricePreference': pricePreference,
      'viewedProductIds': viewedProductIds,
      'likedProductIds': likedProductIds,
    };
  }

  UserPreference copyWith({
    List<String>? favoriteStyles,
    List<String>? favoriteCategories,
    String? pricePreference,
    List<String>? viewedProductIds,
    List<String>? likedProductIds,
  }) {
    return UserPreference(
      favoriteStyles: favoriteStyles ?? this.favoriteStyles,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      pricePreference: pricePreference ?? this.pricePreference,
      viewedProductIds: viewedProductIds ?? this.viewedProductIds,
      likedProductIds: likedProductIds ?? this.likedProductIds,
    );
  }

  @override
  List<Object?> get props => [
        favoriteStyles,
        favoriteCategories,
        pricePreference,
        viewedProductIds,
        likedProductIds,
      ];
}
