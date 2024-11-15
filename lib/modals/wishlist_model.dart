import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/product_class.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishListodel extends StatelessWidget {
  const WishListodel({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(product.imagesUrl[0]),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            product.price.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<Wish>()
                                        .removeItem(product);
                                  },
                                  icon:
                                      const Icon(Icons.delete_forever)),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    var existingProduct = context
                                        .read<Cart>()
                                        .getItems
                                        .firstWhereOrNull((element) =>
                                            element.documentId ==
                                            product.documentId);
    
                                    if (existingProduct != null) {
                                      print('in cart');
                                    } else {
                                      context.read<Cart>().addItem(
                                          product.name,
                                          product.price,
                                          1,
                                          product.qntty,
                                          product.imagesUrl,
                                          product.documentId,
                                          product.suppId
                                        );
                                        context
                                        .read<Wish>()
                                        .removeItem(product);
                                    }
                                  },
                                  icon: const Icon(Icons.shopping_cart,color: Colors.black,))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptWishList extends StatelessWidget {
  const EmptWishList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Your Wishlist is Empty!',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 3, 3, 3),
          ),
        ),
      ),
    );
  }
}
