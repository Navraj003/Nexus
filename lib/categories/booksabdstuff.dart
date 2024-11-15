import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/subcat.dart';
import 'package:nexus_app/categories/categ_list.dart';

List<String> images = [
  'lib/assets/pngimg.com - book_PNG51074 (1).png',
    'lib/assets/th (1).jpg',
    'lib/assets/Carson-Dunlop-Home-Reference-Soft-Cover.png',
    'lib/assets/notebook_PNG19218.png',
    'lib/assets/Lamp-Transparent-Free-PNG.png',
    'lib/assets/pngtree-binder-business-shelf-file-png-image_6446253.jpg',
    'lib/assets/Scientific-Calculator-Download-PNG-Image.png',
    'lib/assets/others-icon-13.jpg',

];

class Booksandstuffs extends StatelessWidget {
  const Booksandstuffs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Books and Stuffs',
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
                                    subcategname: cat3[index+1],
                                  )));
                    },
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      ),
                      Text(
                        cat3[index+1],
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
