import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String paymentMethod;
  final DateTime createdAt;
  final String status;
  final String estimatedDelivery;

  const Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.createdAt,
    required this.status,
    required this.estimatedDelivery,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
      estimatedDelivery: json['estimatedDelivery'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'estimatedDelivery': estimatedDelivery,
    };
  }

  @override
  List<Object?> get props => [
        id,
        items,
        totalAmount,
        paymentMethod,
        createdAt,
        status,
        estimatedDelivery,
      ];
}
