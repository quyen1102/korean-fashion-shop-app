import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/order_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final OrderRepository orderRepository;

  CheckoutCubit(this.orderRepository) : super(const CheckoutInitial());

  void selectPaymentMethod(String method) {
    emit(CheckoutInitial(selectedPaymentMethod: method));
  }

  Future<void> processPayment({
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    final currentMethod = state is CheckoutInitial
        ? (state as CheckoutInitial).selectedPaymentMethod
        : 'cod';

    emit(CheckoutProcessing());
    
    // Simulate payment gateway delay (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      final timestamp = DateTime.now();
      final orderId = 'SS${timestamp.year}${timestamp.month.toString().padLeft(2, '0')}${timestamp.day.toString().padLeft(2, '0')}${timestamp.hour.toString().padLeft(2, '0')}${timestamp.minute.toString().padLeft(2, '0')}${timestamp.second.toString().padLeft(2, '0')}';
      
      final order = Order(
        id: orderId,
        items: items,
        totalAmount: totalAmount,
        paymentMethod: currentMethod,
        createdAt: timestamp,
        status: 'processing',
        estimatedDelivery: '3–5 days',
      );

      await orderRepository.saveOrder(order);
      emit(CheckoutSuccess(order));
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }

  void reset() {
    emit(const CheckoutInitial());
  }
}
