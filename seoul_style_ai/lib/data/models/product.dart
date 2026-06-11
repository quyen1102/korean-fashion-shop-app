import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final List<String> imageUrls;
  final List<String> sizes;
  final List<String> colors;
  final List<String> styleTags;
  final String priceLevel;
  final bool isTrending;
  final bool isNew;
  final bool isSale;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.imageUrls,
    required this.sizes,
    required this.colors,
    required this.styleTags,
    required this.priceLevel,
    required this.isTrending,
    required this.isNew,
    required this.isSale,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountPercent: json['discountPercent'] as int,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      imageUrls: List<String>.from(json['imageUrls'] as List),
      sizes: List<String>.from(json['sizes'] as List),
      colors: List<String>.from(json['colors'] as List),
      styleTags: List<String>.from(json['styleTags'] as List),
      priceLevel: json['priceLevel'] as String,
      isTrending: json['isTrending'] as bool,
      isNew: json['isNew'] as bool,
      isSale: json['isSale'] as bool,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'discountPercent': discountPercent,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrls': imageUrls,
      'sizes': sizes,
      'colors': colors,
      'styleTags': styleTags,
      'priceLevel': priceLevel,
      'isTrending': isTrending,
      'isNew': isNew,
      'isSale': isSale,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        category,
        price,
        originalPrice,
        discountPercent,
        rating,
        reviewCount,
        imageUrls,
        sizes,
        colors,
        styleTags,
        priceLevel,
        isTrending,
        isNew,
        isSale,
        description,
      ];
}
