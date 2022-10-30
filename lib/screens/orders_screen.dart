import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

// displays the history or orders the user has made.
// displays the order amount and date the order was made.
class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: orderData.orders.length == 0
          ? Padding (
        padding: EdgeInsets.all(10),
          child: Text(
            'You have no orders!',
            style: Theme.of(context).textTheme.subtitle1,
          )
      )
          : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder:  (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
