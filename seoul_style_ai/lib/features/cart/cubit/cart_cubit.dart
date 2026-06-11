import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/product.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void addItem(Product product, String size, String color) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex = currentItems.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);

    if (existingIndex >= 0) {
      final item = currentItems[existingIndex];
      currentItems[existingIndex] = item.copyWith(quantity: item.quantity + 1);
    } else {
      currentItems.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
        quantity: 1,
      ));
    }
    _recalculate(currentItems);
  }

  void removeItem(Product product, String size, String color) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);
    _recalculate(currentItems);
  }

  void updateQuantity(Product product, String size, String color, int newQty) {
    if (newQty <= 0) {
      removeItem(product, size, color);
      return;
    }
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);
    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(quantity: newQty);
      _recalculate(currentItems);
    }
  }

  void clearCart() {
    emit(CartState.empty());
  }

  void _recalculate(List<CartItem> items) {
    if (items.isEmpty) {
      emit(CartState.empty());
      return;
    }

    double subtotal = 0.0;
    int totalCount = 0;
    for (final item in items) {
      subtotal += item.product.price * item.quantity;
      totalCount += item.quantity;
    }

    // 10% discount if total quantity in cart is 3 or more items
    double discount = 0.0;
    if (totalCount >= 3) {
      discount = subtotal * 0.1;
    }

    // Shipping fee is 15.0 (units of 1000 KRW = 15,000) if subtotal < 100.0 (units of 1000 KRW = 100,000)
    // Else it is free (0.0)
    double shippingFee = 0.0;
    if (subtotal < 100000.0) {
      shippingFee = 15000.0;
    }

    double total = subtotal - discount + shippingFee;

    emit(CartState(
      items: items,
      subtotal: subtotal,
      discount: discount,
      shippingFee: shippingFee,
      total: total,
    ));
  }
}
