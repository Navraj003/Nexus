
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/galleries/accessoriesgallery.dart';
import 'package:nexus_app/galleries/beautygallery.dart';
import 'package:nexus_app/galleries/booksgallery.dart';
import 'package:nexus_app/galleries/clothsandfootwear.dart';
import 'package:nexus_app/galleries/electronicsgallery.dart';
import 'package:nexus_app/galleries/furnitbeddingallery.dart';
import 'package:nexus_app/minor_screens/fake_search.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor:const Color.fromARGB(255, 230, 228, 228),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title:const FakeSearch(),
            bottom: const TabBar(
                isScrollable: true,
                indicatorColor: Color.fromARGB(255, 5, 5, 5),
                tabs: [
                  Reusable(label: 'Electronics'),
                  Reusable(label: 'Accessories'),
                  Reusable(label: 'Books and stuffs'),
                  Reusable(label: 'Beauty'),
                  Reusable(label: 'Cloting and footwear'),
                  Reusable(label: 'Furniture and Bedding'),
                ]),
          ),
          body: const TabBarView(children: [
            Electrronicfgallert(),
            Accessorygallery(),
            Booksgallery(),
            Beautygallery(),
            ClothFootgallert(),
            Furnituteandbeddingallery(),

          ])),
    );
  }
}


class Reusable extends StatelessWidget {
  const Reusable({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 3, 3, 3)),
        ),
      ),
    );
  }
}
