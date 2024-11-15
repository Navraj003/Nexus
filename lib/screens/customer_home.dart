import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/screens/ProfileScreen.dart';
import 'package:nexus_app/screens/DonationBasket.dart';
import 'package:nexus_app/screens/cartscreen.dart';
import 'package:nexus_app/screens/category.dart';
import 'package:nexus_app/screens/homescreen.dart';
import 'package:nexus_app/screens/uploadscreen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;


class Customerhome extends StatefulWidget {
  const Customerhome({super.key});

  @override
  State<Customerhome> createState() => _CustomerhomeState();
}

class _CustomerhomeState extends State<Customerhome> {
  int _selectedindx = 0;
    late final List<Widget> _tabs;
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'guest';
    _tabs = [
    const HomeScreen(),
      const CategoryScreen(),
      BasketScreen(),
      const CartScreenState(),
      const  Upload(),
      ProfileScreen(documentId: userId),
      if(FirebaseAuth.instance.currentUser!=null)
      ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid,),
      

  ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _tabs[_selectedindx],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 3, 3, 3),
          unselectedItemColor: const Color.fromARGB(255, 175, 164, 164),
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
          currentIndex: _selectedindx,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Category'),
            BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Donation Basket'),
          BottomNavigationBarItem(
  icon: badges.Badge(
    showBadge:context.read<Cart>().getItems.isEmpty ? false:true,
    badgeStyle: const badges.BadgeStyle(badgeColor: Colors.black),
    badgeContent: Text(
      context.watch<Cart>().getItems.length.toString(),
      style: const TextStyle(color: Colors.white),
    ),
    child: const Icon(Icons.shopping_cart),
  ),
  label: 'Cart', // Add a label here
),

                        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),

          ],
          onTap: (index) {
            setState(() {
              _selectedindx = index;
            });
          },
        ));
  }
}
