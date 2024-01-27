import 'package:fetchme/models/cart_model.dart';
import 'package:fetchme/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final int index;
  const CartItemCard({
    super.key,
    required this.index,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(product.name),
          leading: Image.network(
            product.imageUrl,
            width: 100,
          ),
          subtitle: Text('\$${product.price}'),
          trailing: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Provider.of<CartModel>(context, listen: false)
                  .removeItemFromCart(index);
            },
          ),
        ),
      ),
    );
  }
}
