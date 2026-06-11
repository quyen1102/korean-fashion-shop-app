import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String selectedCategory;
  final String searchQuery;
  final String? priceLevelFilter;
  final bool isSaleFilter;
  final String selectedSortOrder; // popular | newest | priceLow | discountHigh

  const ProductLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.selectedCategory = 'all',
    this.searchQuery = '',
    this.priceLevelFilter,
    this.isSaleFilter = false,
    this.selectedSortOrder = 'popular',
  });

  ProductLoaded copyWith({
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    String? selectedCategory,
    String? searchQuery,
    String? priceLevelFilter,
    bool? isSaleFilter,
    String? selectedSortOrder,
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      priceLevelFilter: priceLevelFilter,
      isSaleFilter: isSaleFilter ?? this.isSaleFilter,
      selectedSortOrder: selectedSortOrder ?? this.selectedSortOrder,
    );
  }

  @override
  List<Object?> get props => [
        allProducts,
        filteredProducts,
        selectedCategory,
        searchQuery,
        priceLevelFilter,
        isSaleFilter,
        selectedSortOrder,
      ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
