import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getAllProducts();
      emit(ProductLoaded(
        allProducts: products,
        filteredProducts: products,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void setCategory(String category) {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    _updateFilteredList(currentState.copyWith(selectedCategory: category));
  }

  void setSearchQuery(String query) {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    _updateFilteredList(currentState.copyWith(searchQuery: query));
  }

  void applyFilters({String? priceLevel, required bool isSaleOnly}) {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    // We create a new state with updated filters. 
    // Note: since priceLevel is nullable, we handle it explicitly.
    final updatedState = ProductLoaded(
      allProducts: currentState.allProducts,
      filteredProducts: currentState.filteredProducts,
      selectedCategory: currentState.selectedCategory,
      searchQuery: currentState.searchQuery,
      priceLevelFilter: priceLevel,
      isSaleFilter: isSaleOnly,
      selectedSortOrder: currentState.selectedSortOrder,
    );
    _updateFilteredList(updatedState);
  }

  void setSortOrder(String sortOrder) {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    _updateFilteredList(currentState.copyWith(selectedSortOrder: sortOrder));
  }

  void _updateFilteredList(ProductLoaded baseState) {
    var list = List<Product>.from(baseState.allProducts);

    // 1. Filter by Category
    if (baseState.selectedCategory.toLowerCase() != 'all') {
      list = list.where((p) => p.category.toLowerCase() == baseState.selectedCategory.toLowerCase()).toList();
    }

    // 2. Filter by Search Query
    if (baseState.searchQuery.isNotEmpty) {
      final q = baseState.searchQuery.toLowerCase();
      list = list.where((p) => 
        p.name.toLowerCase().contains(q) || 
        p.brand.toLowerCase().contains(q) ||
        p.styleTags.any((tag) => tag.toLowerCase().contains(q))
      ).toList();
    }

    // 3. Filter by Price Level
    if (baseState.priceLevelFilter != null) {
      list = list.where((p) => p.priceLevel.toLowerCase() == baseState.priceLevelFilter!.toLowerCase()).toList();
    }

    // 4. Filter by Sale
    if (baseState.isSaleFilter) {
      list = list.where((p) => p.isSale).toList();
    }

    // 5. Apply Sorting
    switch (baseState.selectedSortOrder) {
      case 'newest':
        list = list.where((p) => p.isNew).toList() + list.where((p) => !p.isNew).toList(); // Simple simulation of newest first
        break;
      case 'priceLow':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'discountHigh':
        list.sort((a, b) => b.discountPercent.compareTo(a.discountPercent));
        break;
      case 'popular':
      default:
        list.sort((a, b) => b.rating.compareTo(a.rating)); // Rating as popular measure
        break;
    }

    emit(baseState.copyWith(filteredProducts: list));
  }
}
