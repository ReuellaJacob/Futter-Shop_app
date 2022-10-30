import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

// displays the product grid to the user and any favorite products.
class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  // displays given products in a grid view.
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    if (this.showFavs && productsData.favoriteItems.length == 0) {
      return Padding (
          padding: EdgeInsets.all(10),
          child: Text(
            'You have no favourites!',
            style: Theme.of(context).textTheme.subtitle1,
          )
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) =>
            ChangeNotifierProvider.value(
              // builder: (c) => products[i],
              value: products[i],
              child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
              ),
            ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
    }
  }
}
