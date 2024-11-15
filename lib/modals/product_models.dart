import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/product_details.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;
  const ProductModel({
    super.key,
    required this.products,
  });

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetails(prolist: widget.products),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 113, 112, 112).withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
                  child: Image.network(
                    widget.products['proimages'][0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products['proname'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.products['prodesc'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ ${widget.products['price'].toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Consumer<Wish>(
                          builder: (context, wishProvider, child) {
                            bool isInWishlist = wishProvider.getWishItems.firstWhereOrNull(
                                  (product) => product.documentId == widget.products['proid'],
                                ) !=
                                null;

                            return IconButton(
                              onPressed: () {
                                if (isInWishlist) {
                                  context.read<Wish>().removeThis(widget.products['proid']);
                                } else {
                                  context.read<Wish>().addWishItem(
                                    widget.products['proname'],
                                    widget.products['price'],
                                    1,
                                    widget.products['instock'],
                                    widget.products['proimages'],
                                    widget.products['proid'],
                                    widget.products['sid'],
                                  );
                                }
                              },
                              icon: Icon(
                                isInWishlist ? Icons.favorite : Icons.favorite_border_outlined,
                                color: isInWishlist ? Colors.black : null,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
