import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/fullscreen.dart';
import 'package:nexus_app/modals/product_models.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:nexus_app/screens/cartscreen.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetails extends StatefulWidget {
  final dynamic prolist;
  const ProductDetails({super.key, required this.prolist});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  late List<dynamic> imageslist = widget.prolist['proimages'];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.prolist['maincateg'])
        .where('subcateg', isEqualTo: widget.prolist['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldkey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                FullScreenView(imagesList: imageslist)));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Swiper(
                            itemBuilder: (context, index) {
                              return Image(
                                  image: NetworkImage(imageslist[index]));
                            },
                            itemCount: imageslist.length),
                      ),
                      Positioned(
                        left: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.prolist['proname'],
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 3, 3, 3)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(' ₹ ',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 3, 3, 3)),
                                    )),
                                Text(widget.prolist['price'].toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 3, 3, 3)),
                                    )),
                              ]),
                          Consumer<Wish>(
  builder: (context, wishProvider, child) {
    bool isInWishlist = wishProvider.getWishItems.firstWhereOrNull(
      (product) => product.documentId == widget.prolist['proid']) != null;

    return IconButton(
      onPressed: () {
  if (context.read<Wish>().getWishItems.any((product) => product.documentId == widget.prolist['proid'])) {
    context.read<Wish>().removeThis(widget.prolist['proid']);
  } else {
    context.read<Wish>().addWishItem(
      widget.prolist['proname'],
      widget.prolist['price'],
      1,
      widget.prolist['instock'],
      widget.prolist['proimages'],
      widget.prolist['proid'],
      widget.prolist['sid'],
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
                Text(
                    (widget.prolist['instock'].toString()) +
                        (' pieces available in stock'),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 144, 143, 143)),
                    )),
                const ProductDetailLabel(
                  label: ' Item Description ',
                ),
                Text(
                  widget.prolist['prodesc'],
                  textScaleFactor: 1.1,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                ),
                const ProductDetailLabel(
                  label: ' Similar Items ',
                ),
                SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: _productsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("Waiting for data...");
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 3, 3, 3),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'This Category \n \n has no items yet!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 3, 3, 3),
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("Waiting for data...");
                    } else if (snapshot.hasData) {
                      print(
                          "Data received: ${snapshot.data!.docs.length} items");
                    } else if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                    }

                    return SingleChildScrollView(
                      child: StaggeredGridView.countBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return ProductModel(
                              products: snapshot.data!.docs[index],
                            );
                          },
                          staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1)),
                    );
                  },
                ))
              ]),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.store,
                  //       color: Color.fromARGB(255, 3, 3, 3),
                  //     )),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>const CartScreenState()));
                    },
                    icon: badges.Badge(
                      
                      badgeStyle:const badges.BadgeStyle(badgeColor: Colors.black),
                      badgeContent: Text(context.watch<Cart>().getItems.length.toString(),style:const TextStyle(color: Colors.white),),
                      child: const  Icon(Icons.shopping_cart,
                            color: Color.fromARGB(255, 3, 3, 3)),
                    ),
                    ), const
                  SizedBox(width: 36),
                  OutlinedButton(
  onPressed: () {
    var existingProduct = context.read<Cart>().getItems.firstWhereOrNull(
        (product) => product.documentId == widget.prolist['proid']);
        
    if (existingProduct != null) {
      _scaffoldkey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('This item is already in your cart.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      context.read<Cart>().addItem(
        widget.prolist['proname'],
        widget.prolist['price'],
        1,
        widget.prolist['instock'],
        widget.prolist['proimages'],
        widget.prolist['proid'],
        widget.prolist['sid']
      );
    }
    print("Images list length: ${imageslist.length}");
  },
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
    side: const BorderSide(color: Colors.black),
    backgroundColor: const Color.fromARGB(255, 3, 3, 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  ),
  child: Text(
    'Add to Cart',
    style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 253, 253, 253),
      ),
    ),
  ),
)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailLabel extends StatelessWidget {
  final String label;
  const ProductDetailLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Color.fromARGB(255, 223, 221, 221),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
