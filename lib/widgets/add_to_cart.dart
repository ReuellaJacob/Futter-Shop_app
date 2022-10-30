import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class AddToCart extends StatefulWidget {
  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var _cartItemQuantity = 0;

  void _addMultipleCartItem(ctx, cart, loadedProduct) {
    if (_cartItemQuantity != 0) {
      for(var i = 0; i < _cartItemQuantity; i++) {
        cart.addItem(
            loadedProduct.id, loadedProduct.price, loadedProduct.title);
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added item to cart!',
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              for(var i = 0; i < _cartItemQuantity; i++) {
                cart.removeSingleItem(loadedProduct.id);
              }
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to add item to cart. Please try again later',
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    final productId =
    ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            child: Text("Add to Cart"),
            style: Theme
                .of(context)
                .textButtonTheme
                .style,
            onPressed: _cartItemQuantity == 0 ? null : () { return _addMultipleCartItem(context, cart, loadedProduct);},
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  if (_cartItemQuantity > 1) {
                    _cartItemQuantity--;
                  }
                });
                print(_cartItemQuantity);
              },
              color: Theme.of(context).primaryColor,
            ),
            Text(_cartItemQuantity.toString()),
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  _cartItemQuantity++;
                });
                print(_cartItemQuantity);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
