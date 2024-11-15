import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Material(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(255, 243, 235, 235),
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      'Place Order',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 3, 3, 3)),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Name:${data['name']}',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ),
                                Text(
                                  'Phone:${data['phone']}',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ),
                                Text(
                                  'Address:${data['address']}',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Consumer<Cart>(
                              builder: (context, cart, child) {
                                return ListView.builder(
                                  itemCount: cart.count,
                                  itemBuilder: (context, index) {
                                    final order = cart.getItems[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                      order.imagesUrl.first)),
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    order.name,
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        order.price.toString(),
                                                        style: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black)),
                                                      ),
                                                      Text(
                                                        'x ${order.qty.toString()}',
                                                        style: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  bottomSheet: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 3, 3, 3),
                          borderRadius: BorderRadius.zero),
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          'Confirm Order',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
