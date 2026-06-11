import '../models/user_preference.dart';

abstract class PreferenceRepository {
  Future<UserPreference> getUserPreference();
  Future<void> saveUserPreference(UserPreference pref);
  Future<void> addViewedProduct(String productId);
  Future<void> toggleLikedProduct(String productId);
}
