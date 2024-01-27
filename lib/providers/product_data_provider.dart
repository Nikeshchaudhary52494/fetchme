import 'package:flutter/material.dart';
import 'package:fetchme/models/product_model.dart';
import 'package:fetchme/services/firestore.dart';

class ProductDataProvider extends ChangeNotifier {
  List<Product> _productList = [];
  List<Product> _searchResults = [];

  List<Product> get productList =>
      _searchResults.isNotEmpty ? _searchResults : _productList;

  final FirestoreServices _firestoreServices = FirestoreServices();

  Future<void> fetchData() async {
    try {
      _productList = await _firestoreServices.getAllProducts();
      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void updateSearchResults(List<Product> searchResults) {
    _searchResults = searchResults;
    notifyListeners();
  }

  List<Product> searchFromAllProducts(String query) {
    return _productList
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
