import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/subcat.dart';
import 'package:nexus_app/categories/categ_list.dart';

List<String> images = [
    'lib/assets/accessories/accessories0.jpg',
    'lib/assets/accessories/accessories1.jpg',
    'lib/assets/accessories/accessories2.jpg',
    'lib/assets/accessories/accessories3.jpg',
    'lib/assets/accessories/accessories4.jpg',
    'lib/assets/accessories/accessories5.jpg',
    'lib/assets/accessories/accessories6.jpg',
    'lib/assets/accessories/accessories7.jpg',
    'lib/assets/accessories/accessories8.jpg',
    'lib/assets/accessories/accessories9.jpg',
    'lib/assets/accessories/bags0.jpg',
    'lib/assets/accessories/bags1.jpg',
    'lib/assets/accessories/bags2.jpg',
    'lib/assets/accessories/bags3.jpg',
    'lib/assets/accessories/bags4.jpg',
    'lib/assets/accessories/bags5.jpg',
    'lib/assets/others-icon-13.jpg',
];

class Accessories extends StatelessWidget {
  const Accessories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Accessories',
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
                                    subcategname: cat2[index+1],
                                  )));
                    },
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      ),
                      Text(
                        cat2[index+1],
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
