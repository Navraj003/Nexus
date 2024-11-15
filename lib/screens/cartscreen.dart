import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/checkoutscreen.dart';
import 'package:nexus_app/modals/cartmodel.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/product_class.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class CartScreenState extends StatefulWidget {
  const CartScreenState({super.key});

  @override
  State<CartScreenState> createState() => _CartScreenStateState();
}

class _CartScreenStateState extends State<CartScreenState> {
  @override
  Widget build(BuildContext context) {
    late double total = context.watch<Cart>().totalPrice;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 235, 235),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Cart',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 3, 3, 3)),
            ),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Clear Cart'),
                            content:
                                const Text('Are you sure to clear the cart?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog without clearing the cart
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<Cart>()
                                      .clearCart(); // Clear the cart
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
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
        body: const CartItems(),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Row(
              children: [
                Text(
                  'Total: ₹',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 3, 3, 3),
                    ),
                  ),
                ),
                Text(
                  total.toString(),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 3, 3, 3),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  color: total == 0.0
                      ? Color.fromARGB(255, 80, 80, 80)
                      : Color.fromARGB(255, 3, 3, 3),
                  borderRadius: BorderRadius.zero),
              child: MaterialButton(
                onPressed: total == 0.0
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const CheckOutScreen()));
                      },
                child: const Text(
                  'CHECK OUT',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        if (cart.count == 0) {
          return Center(
            child: Text(
              'Your Cart is Empty!',
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
        return ListView.builder(
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final product = cart.getItems[index];
            return CartModel(
              product: product,
              cart: context.read<Cart>(),
            );
          },
        );
      },
    );
  }
}
