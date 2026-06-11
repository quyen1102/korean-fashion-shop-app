import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_preference.dart';
import '../../../data/repositories/preference_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final PreferenceRepository preferenceRepository;

  PreferenceCubit(this.preferenceRepository) : super(PreferenceInitial());

  Future<void> loadPreference() async {
    emit(PreferenceLoading());
    try {
      final pref = await preferenceRepository.getUserPreference();
      emit(PreferenceLoaded(pref));
    } catch (e) {
      emit(PreferenceError(e.toString()));
    }
  }

  Future<void> savePreference({
    required List<String> favoriteStyles,
    required List<String> favoriteCategories,
    required String pricePreference,
  }) async {
    emit(PreferenceLoading());
    try {
      final currentPref = state is PreferenceLoaded 
          ? (state as PreferenceLoaded).preference 
          : UserPreference.empty();
      
      final updatedPref = currentPref.copyWith(
        favoriteStyles: favoriteStyles,
        favoriteCategories: favoriteCategories,
        pricePreference: pricePreference,
      );
      
      await preferenceRepository.saveUserPreference(updatedPref);
      emit(PreferenceLoaded(updatedPref));
    } catch (e) {
      emit(PreferenceError(e.toString()));
    }
  }

  Future<void> addViewedProduct(String productId) async {
    try {
      await preferenceRepository.addViewedProduct(productId);
      if (state is PreferenceLoaded) {
        final currentPref = (state as PreferenceLoaded).preference;
        final updatedViews = List<String>.from(currentPref.viewedProductIds);
        if (!updatedViews.contains(productId)) {
          updatedViews.add(productId);
          if (updatedViews.length > 20) updatedViews.removeAt(0);
          emit(PreferenceLoaded(currentPref.copyWith(viewedProductIds: updatedViews)));
        }
      }
    } catch (_) {}
  }

  Future<void> toggleLikedProduct(String productId) async {
    try {
      await preferenceRepository.toggleLikedProduct(productId);
      if (state is PreferenceLoaded) {
        final currentPref = (state as PreferenceLoaded).preference;
        final updatedLikes = List<String>.from(currentPref.likedProductIds);
        if (updatedLikes.contains(productId)) {
          updatedLikes.remove(productId);
        } else {
          updatedLikes.add(productId);
        }
        emit(PreferenceLoaded(currentPref.copyWith(likedProductIds: updatedLikes)));
      }
    } catch (_) {}
  }
}
