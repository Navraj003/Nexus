import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/subcat.dart';
import 'package:nexus_app/categories/categ_list.dart';

List<String> images = [
  'lib/assets/furnitureandbedding/th (2).jpg',
  'lib/assets/furnitureandbedding/vase_PNG85.png',
  'lib/assets/furnitureandbedding/Decorative-Light-PNG-Transparent-Image.png',
  'lib/assets/furnitureandbedding/f7e06d86-be89-4cb2-8696-388569001fb7.png',
  'lib/assets/furnitureandbedding/free-png-download-transparent-bed-sheet-image-28468.png',
  'lib/assets/others-icon-13.jpg',
];

class FurnitureandBedding extends StatelessWidget {
  const FurnitureandBedding({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Furniture and Bedding',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Color.fromARGB(255, 3, 3, 3)),
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.68,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: images.length-1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => SubCategprod(
                                    subcategname: cat6[index+1],
                                  )));
                    },
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      ),
                      Text(
                        cat6[index+1],
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 60, 60, 60),
                          ),
                        ),
                      ),
                    ]),
                  );
                })),
      ]),
    );
  }
}
