import 'package:fetchme/widgets/cards/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fetchme/models/cart_model.dart';
import 'package:fetchme/models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          double totalPrice = 0.0;
          for (Product product in cart.cartItems) {
            totalPrice += product.price;
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    Product product = cart.cartItems[index];
                    return CartItemCard(
                      product: product,
                      index: index,
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Total price:",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "\$ $totalPrice",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Add your payment logic here
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
