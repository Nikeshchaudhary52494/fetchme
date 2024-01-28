import 'package:fetchme/providers/product_data_provider.dart';
import 'package:fetchme/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fetchme/models/product_model.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final FirestoreServices _firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Product product = Product(
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      category: _categoryController.text,
                      imageUrl: _imageUrlController.text,
                    );
                    final productDataProvider =
                        Provider.of<ProductDataProvider>(
                      context,
                      listen: false,
                    );
                    await _firestoreServices.addProduct(product);
                    await productDataProvider.refreshData();

                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
