import 'package:flutter/foundation.dart';

import './cart.dart';

// a model that represents an order made by the user.
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

// functions for the orders model.
class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  // return all ordered objects.
  List<OrderItem> get orders {
    return [..._orders];
  }

  // appends an order to the user's shopping cart.
  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
