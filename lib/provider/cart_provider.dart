import 'package:flutter/cupertino.dart';
import 'package:nexus_app/provider/product_class.dart';



class Cart extends ChangeNotifier {
  final List<Product> _list = [];  //db mein store, //note*  cart ko empty
  List<Product> get getItems => _list;
  double get totalPrice {
    var total = 0.0;
    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  int get count => _list.length; // Add return statement for count

  void addItem(
    String name,
    double price, // Corrected the parameter name here
    int qty,
    int qntty,
    List<dynamic> imagesUrl, // Specify imagesUrl as List<String>
    String documentId,
    String suppId,
  ) {
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

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
