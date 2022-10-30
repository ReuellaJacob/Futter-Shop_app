import 'package:flutter/foundation.dart';

// a model that represents a shopping for cart.
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

// constructor
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

// functions for the cart model.
class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  // returns the number of items in the user's shopping cart.
  int get itemCount {
    return _items.length;
  }

  // returns the number of quantity in the user's shopping cart.
  int get quantityCount {
    int count = 0;
    _items.forEach((key, cartItem) {
      count += cartItem.quantity;
    });
    return count;
  }

  // returns the sum of all the products in the user's shopping cart.
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // appends a product to user's shopping cart.
  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // removes given product from the user's shopping cart.
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // removes a quantiy of a given item.
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // removes all products from the user's shopping cart.
  void clear() {
    _items = {};
    notifyListeners();
  }
}
