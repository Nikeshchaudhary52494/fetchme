import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchme/models/product_model.dart';

class FirestoreServices {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(Product product) async {
    await products.add({
      'name': product.name,
      'price': product.price,
      'category': product.category,
      'imageUrl': product.imageUrl,
    });
  }

  Future<List<Product>> getAllProducts() async {
    QuerySnapshot querySnapshot = await products.get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Product(
        name: data['name'],
        price: data['price'],
        category: data['category'],
        imageUrl: data['imageUrl'],
      );
    }).toList();
  }

  Future<void> deleteProduct(String productId) async {
    await products.doc(productId).delete();
  }
}
