import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/categories/acessories.dart';
import 'package:nexus_app/categories/beauty.dart';
import 'package:nexus_app/categories/booksabdstuff.dart';
import 'package:nexus_app/categories/clothes_and_footwear.dart';
import 'package:nexus_app/categories/electronics.dart';
import 'package:nexus_app/categories/furnitureandbedding.dart';
import 'package:nexus_app/minor_screens/fake_search.dart';

List<ItemsData> items = [
  ItemsData(label: 'Electronics'),
  ItemsData(label: 'Accessories'),
  ItemsData(label: 'Books and stuffs'),
  ItemsData(label: 'Beauty'),
  ItemsData(label: 'Clothes and Footwear'),
  ItemsData(label: 'Fruniture and Bediing'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              child: sideNavigatorS(
                size,
              )),
          Positioned(bottom: 0, right: 0, child: CategView(size)),
        ],
      ),
    );
  }

  Widget sideNavigatorS(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                /*for (var element in items) {
                  element.isSelected = false;
                }
                setState(() {
                  items[index].isSelected = true;
                }); */
                _pageController.animateToPage(index,
                    duration:const Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
              },
              child: Container(
                color: items[index].isSelected == true
                    ? Colors.white
                    : const Color.fromARGB(255, 3, 3, 3),
                height: 100,
                child: Center(
                  child: Text(
                    items[index].label,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 127, 124, 124)),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget CategView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: [
          Electronics(),
          Accessories(),
          Booksandstuffs(),
          Beauty(),
          Wear(),
          FurnitureandBedding()
        ],
      ),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected = false});
}
