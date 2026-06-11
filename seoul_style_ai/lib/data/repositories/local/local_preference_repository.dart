import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_preference.dart';
import '../preference_repository.dart';

class LocalPreferenceRepository implements PreferenceRepository {
  final SharedPreferences sharedPreferences;
  static const String _key = 'user_preference';

  LocalPreferenceRepository(this.sharedPreferences);

  @override
  Future<UserPreference> getUserPreference() async {
    final String? jsonStr = sharedPreferences.getString(_key);
    if (jsonStr == null) return UserPreference.empty();
    try {
      return UserPreference.fromJson(
          json.decode(jsonStr) as Map<String, dynamic>);
    } catch (_) {
      return UserPreference.empty();
    }
  }

  @override
  Future<void> saveUserPreference(UserPreference pref) async {
    await sharedPreferences.setString(_key, json.encode(pref.toJson()));
  }

  @override
  Future<void> addViewedProduct(String productId) async {
    final pref = await getUserPreference();
    final updatedViews = List<String>.from(pref.viewedProductIds);
    if (!updatedViews.contains(productId)) {
      updatedViews.add(productId);
      // Keep only last 20 viewed products
      if (updatedViews.length > 20) {
        updatedViews.removeAt(0);
      }
      await saveUserPreference(pref.copyWith(viewedProductIds: updatedViews));
    }
  }

  @override
  Future<void> toggleLikedProduct(String productId) async {
    final pref = await getUserPreference();
    final updatedLikes = List<String>.from(pref.likedProductIds);
    if (updatedLikes.contains(productId)) {
      updatedLikes.remove(productId);
    } else {
      updatedLikes.add(productId);
    }
    await saveUserPreference(pref.copyWith(likedProductIds: updatedLikes));
  }
}
