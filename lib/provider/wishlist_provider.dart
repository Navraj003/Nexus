import 'package:flutter/cupertino.dart';
import 'package:nexus_app/provider/product_class.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems => _list;

  int get count => _list.length; // Add return statement for count

  Future<void> addWishItem(
    String name,
    double price, // Corrected the parameter name here
    int qty,
    int qntty,
    List<dynamic> imagesUrl, // Specify imagesUrl as List<String>
    String documentId,
    String suppId,
  ) async{
    final product = Product(
      documentId: documentId,
      imagesUrl: imagesUrl.cast<String>(),
      name: name,
      price: price, // Corrected this line to use the price parameter
      qntty: qntty,
      qty: qty,
      suppId: suppId,
    );

    _list.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishlist() {
    _list.clear();
    notifyListeners();
  }

  void removeThis(String id) {
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}
