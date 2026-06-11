import 'package:equatable/equatable.dart';
import 'product.dart';

class CartItem extends Equatable {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  final int quantity;

  const CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      selectedSize: json['selectedSize'] as String,
      selectedColor: json['selectedColor'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
    };
  }

  CartItem copyWith({
    Product? product,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, selectedSize, selectedColor, quantity];
}
