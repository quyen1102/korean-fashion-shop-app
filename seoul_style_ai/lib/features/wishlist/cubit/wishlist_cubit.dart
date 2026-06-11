import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/preference_repository.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final PreferenceRepository preferenceRepository;

  WishlistCubit(this.preferenceRepository) : super(const WishlistState({}));

  Future<void> loadWishlist() async {
    try {
      final pref = await preferenceRepository.getUserPreference();
      emit(WishlistState(pref.likedProductIds.toSet()));
    } catch (_) {}
  }

  Future<void> toggleWishlist(String productId) async {
    final currentIds = Set<String>.from(state.productIds);
    if (currentIds.contains(productId)) {
      currentIds.remove(productId);
    } else {
      currentIds.add(productId);
    }
    emit(WishlistState(currentIds));
    try {
      await preferenceRepository.toggleLikedProduct(productId);
    } catch (_) {}
  }
}
