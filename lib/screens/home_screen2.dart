import 'package:fetchme/providers/theme_provider.dart';
import 'package:fetchme/screens/cart_screen.dart';
import 'package:fetchme/widgets/drawer.dart';
import 'package:fetchme/widgets/product_list.dart';
import 'package:fetchme/widgets/search_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fetchme/providers/product_data_provider.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).brightness == Brightness.light
            ? const IconThemeData(color: Colors.white)
            : IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Image.asset(
          'lib/images/fetchme.png',
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Theme.of(context).colorScheme.primary,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          MySearchBar2(
            productList: Provider.of<ProductDataProvider>(context).productList,
            onSearchResultsUpdated: (searchResults) {
              Provider.of<ProductDataProvider>(context, listen: false)
                  .updateSearchResults(searchResults);
            },
          ),
          Consumer<ProductDataProvider>(
            builder: (context, productConsumer, child) {
              if (productConsumer.productList.isEmpty) {
                productConsumer.fetchData();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ProductList(products: productConsumer.productList);
              }
            },
          ),
        ],
      ),
    );
  }
}
