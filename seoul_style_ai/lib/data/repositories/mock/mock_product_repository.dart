import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/product.dart';
import '../product_repository.dart';

class MockProductRepository implements ProductRepository {
  List<Product>? _cachedProducts;

  Future<List<Product>> _loadProducts() async {
    if (_cachedProducts != null) return _cachedProducts!;

    final String response = await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;
    
    _cachedProducts = data.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    return _cachedProducts!;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return _loadProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await _loadProducts();
    if (category.toLowerCase() == 'all') return products;
    return products.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    final products = await _loadProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await _loadProducts();
    if (query.isEmpty) return products;
    final normalizedQuery = query.toLowerCase();
    return products.where((p) {
      return p.name.toLowerCase().contains(normalizedQuery) ||
             p.brand.toLowerCase().contains(normalizedQuery) ||
             p.description.toLowerCase().contains(normalizedQuery) ||
             p.styleTags.any((tag) => tag.toLowerCase().contains(normalizedQuery));
    }).toList();
  }

  @override
  Future<List<Product>> filterProducts({
    String? category,
    String? priceLevel,
    bool? isSale,
    List<String>? styleTags,
  }) async {
    var products = await _loadProducts();

    if (category != null && category.toLowerCase() != 'all') {
      products = products.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
    }
    
    if (priceLevel != null) {
      products = products.where((p) => p.priceLevel.toLowerCase() == priceLevel.toLowerCase()).toList();
    }

    if (isSale != null && isSale) {
      products = products.where((p) => p.isSale).toList();
    }

    if (styleTags != null && styleTags.isNotEmpty) {
      products = products.where((p) {
        return p.styleTags.any((tag) => styleTags.contains(tag));
      }).toList();
    }

    return products;
  }
}
