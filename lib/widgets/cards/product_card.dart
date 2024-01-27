import "package:flutter/material.dart";

class ProductCard extends StatelessWidget {
  final String name;
  final String itemPrice;
  final String imagePath;
  final void Function()? onPressed;
  const ProductCard(
      {super.key,
      required this.name,
      required this.itemPrice,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(20, 20),
                blurRadius: 25)
          ],
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image.network(
            imagePath,
            width: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "\$$itemPrice",
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Set the background color here
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white, // Set the icon color here
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
