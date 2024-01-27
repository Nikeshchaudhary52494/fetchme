import 'package:fetchme/models/cart_model.dart';
import 'package:fetchme/models/product_model.dart';
import 'package:fetchme/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            name: products[index].name,
            itemPrice: products[index].price.toString(),
            imagePath: products[index].imageUrl,
            onPressed: () => Provider.of<CartModel>(context, listen: false)
                .addItemToCart(products[index]),
          );
        },
      ),
    );
  }
}
