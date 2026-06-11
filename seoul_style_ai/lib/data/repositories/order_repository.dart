import '../models/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<void> saveOrder(Order order);
}
