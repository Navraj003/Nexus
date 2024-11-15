import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/modals/product_models.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Booksgallery extends StatefulWidget {
  const Booksgallery({super.key});

  @override
  State<Booksgallery> createState() => _Booksgallery();
}

class _Booksgallery extends State<Booksgallery> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products').where('maincateg', isEqualTo: 'books and stuffs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 3, 3, 3),
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
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

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return ProductModel(products: snapshot.data!.docs[index],);
              },
              staggeredTileBuilder: (context) =>const StaggeredTile.fit(1)),
        );
      },
    );
  }
}


