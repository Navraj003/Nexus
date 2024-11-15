import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/dashboard.dart';
import 'package:nexus_app/screens/ProfileScreen.dart';
import 'package:nexus_app/screens/DonationBasket.dart';
import 'package:nexus_app/screens/cartscreen.dart';
import 'package:nexus_app/screens/category.dart';
import 'package:nexus_app/screens/homescreen.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() =>_SupplierHomeScreen();
}

class _SupplierHomeScreen extends State<SupplierHomeScreen> {
    int _selectedindx = 0;
  final List<Widget> _tabs = [
    HomeScreen(),
    CategoryScreen(),
    BasketScreen(),
    DashboardScreen(),
    Center(child: Text('Upload'),),

  ];

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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Category'),
        BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
      ],
      onTap: (index) {
        setState(() {
          _selectedindx = index;
        });
      },
    ));
  }
}