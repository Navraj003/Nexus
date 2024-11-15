import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/modals/wishlist_model.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/product_class.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreen();
}

class _WishListScreen extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 243, 235, 235),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'WishList',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 3, 3, 3)),
          ),
        ),
        actions: [
            context.watch<Wish>().getWishItems.isEmpty? const SizedBox():
            IconButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear WishList'),
          content: const Text('Are you sure to clear the WishList?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without clearing the cart
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<Wish>().clearWishlist(); // Clear the cart
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  },
  icon: const Icon(
    Icons.delete_forever,
    color: Colors.black,
  ),
)
        ],
      ),
      body: context.watch<Wish>().getWishItems.isNotEmpty
          ? WishItems()
          : EmptWishList(),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        if (wish.count == 0) {
          return const EmptWishList();
        }
        return ListView.builder(
          itemCount: wish.count,
          itemBuilder: (context, index) {
            final product = wish.getWishItems[index];
            return WishListodel(product: product);
          },
        );
      },
    );
  }
}

