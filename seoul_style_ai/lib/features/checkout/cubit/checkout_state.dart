import 'package:equatable/equatable.dart';
import '../../../data/models/order.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  final String selectedPaymentMethod;

  const CheckoutInitial({this.selectedPaymentMethod = 'cod'});

  @override
  List<Object?> get props => [selectedPaymentMethod];
}

class CheckoutProcessing extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final Order order;

  const CheckoutSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}
