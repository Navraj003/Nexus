class Product {
  String name;
  double price;
  int qty = 1;
  int qntty;
  List<dynamic> imagesUrl; // Define imagesUrl as List<String>
  String documentId;
  String suppId;

  Product({
    required this.documentId,
    required this.imagesUrl,
    required this.name,
    required this.price,
    required this.qntty,
    required this.qty,
    required this.suppId,
  });

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}