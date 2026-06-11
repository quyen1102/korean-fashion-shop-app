import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product?> getProductById(String id);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> filterProducts({
    String? category,
    String? priceLevel,
    bool? isSale,
    List<String>? styleTags,
  });
}
