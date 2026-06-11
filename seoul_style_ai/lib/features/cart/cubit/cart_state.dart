import 'package:equatable/equatable.dart';
import '../../../data/models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double shippingFee;
  final double total;

  const CartState({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.shippingFee,
    required this.total,
  });

  factory CartState.empty() {
    return const CartState(
      items: [],
      subtotal: 0.0,
      discount: 0.0,
      shippingFee: 0.0,
      total: 0.0,
    );
  }

  CartState copyWith({
    List<CartItem>? items,
    double? subtotal,
    double? discount,
    double? shippingFee,
    double? total,
  }) {
    return CartState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shippingFee: shippingFee ?? this.shippingFee,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [items, subtotal, discount, shippingFee, total];
}
