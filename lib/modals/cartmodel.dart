import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/product_class.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class CartModel extends StatelessWidget {
  const CartModel({
    super.key,
    required this.product,
    required this.cart,
  });

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                height: 100,
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
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 3, 3, 3),
                                borderRadius: BorderRadius.circular(1)),
                            child: Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  product.qty == 1
                                      ? IconButton(
                                          onPressed: () {
                                            showCupertinoModalPopup<void>(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    CupertinoActionSheet(
                                                      title:
                                                          const Text('Delete'),
                                                      message: const Text(
                                                          'Are you sure you want to delete this product?'),
                                                      actions: <CupertinoActionSheetAction>[
                                                        CupertinoActionSheetAction(
                                                          child: const Text(
                                                            'Delete',
                                                          ),
                                                          onPressed: () {
                                                            context
                                                                .read<Cart>()
                                                                .removeItem(
                                                                    product);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        CupertinoActionSheetAction(
                                                            child: const Text(
                                                                'Add to WishList'),
                                                            onPressed:
                                                                () async {
                                                              context.read<Wish>().getWishItems.firstWhereOrNull((element) =>
                                                                          element
                                                                              .documentId ==
                                                                          product
                                                                              .documentId) !=
                                                                      null
                                                                  ? context
                                                                      .read<
                                                                          Cart>()
                                                                      .removeItem(
                                                                          product)
                                                                  : await context.read<Wish>().addWishItem(
                                                                      product
                                                                          .name,
                                                                      product
                                                                          .price,
                                                                      1,
                                                                      product
                                                                          .qntty,
                                                                      product
                                                                          .imagesUrl,
                                                                      product
                                                                          .documentId,
                                                                      product
                                                                          .suppId);
                                                              context
                                                                  .read<Cart>()
                                                                  .removeItem(
                                                                      product);
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        CupertinoActionSheetAction(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ],
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size: 13,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            cart.decrement(product);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 13,
                                          )),
                                  Text(
                                    product.qty.toString(),
                                    style: product.qty == product.qntty
                                        ? GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                255, 188, 168, 168),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          )
                                        : GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                  ),
                                  IconButton(
                                    onPressed: product.qty == product.qntty
                                        ? null
                                        : () {
                                            cart.increment(product);
                                          },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    iconSize: 13,
                                  ),
                                ],
                              ),
                            ),
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
