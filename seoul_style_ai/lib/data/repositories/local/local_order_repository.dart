import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/order.dart';
import '../order_repository.dart';

class LocalOrderRepository implements OrderRepository {
  final SharedPreferences sharedPreferences;
  static const String _key = 'orders_history';

  LocalOrderRepository(this.sharedPreferences);

  @override
  Future<List<Order>> getOrders() async {
    final String? jsonStr = sharedPreferences.getString(_key);
    if (jsonStr == null) return [];
    try {
      final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;
      return list
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveOrder(Order order) async {
    final orders = await getOrders();
    // Insert new order at the beginning of the list (newest first)
    orders.insert(0, order);
    final listJson = orders.map((o) => o.toJson()).toList();
    await sharedPreferences.setString(_key, json.encode(listJson));
  }
}
