import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/subcat.dart';
import 'package:nexus_app/categories/categ_list.dart';

List<String> imagetry = [
  'lib/assets/clothes/men0.jpg',
  'lib/assets/clothes/men1.jpg',
  'lib/assets/clothes/men2.jpg',
  'lib/assets/clothes/men3.jpg',
  'lib/assets/clothes/men4.jpg',
  'lib/assets/clothes/men6.jpg',
  'lib/assets/clothes/men7.jpg',
  'lib/assets/clothes/women0.jpg',
  'lib/assets/clothes/women1.jpg',
  'lib/assets/clothes/women2.jpg',
  'lib/assets/clothes/women3.jpg',
  'lib/assets/clothes/women4.jpg',
  'lib/assets/clothes/women5.jpg',
  'lib/assets/clothes/women6.jpg',
  'lib/assets/clothes/women7.jpg',
  'lib/assets/clothes/women8.jpg',
  'lib/assets/clothes/shoes0.jpg',
  'lib/assets/clothes/shoes1.jpg',
  'lib/assets/clothes/shoes2.jpg',
  'lib/assets/clothes/shoes3.jpg',
  'lib/assets/clothes/shoes4.jpg',
  'lib/assets/clothes/shoes5.jpg',
  'lib/assets/clothes/shoes6.jpg',
  'lib/assets/clothes/shoes7.jpg',
  'lib/assets/clothes/shoes8.jpg',
  'lib/assets/clothes/shoes9.jpg',
  'lib/assets/clothes/shoes10.jpg',
  'lib/assets/clothes/shoes11.jpg',
  'lib/assets/clothes/shoes12.jpg',
  'lib/assets/others-icon-13.jpg',
];

class Wear extends StatelessWidget {
  const Wear({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Clothing and Footwear',
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
                itemCount: imagetry.length-1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => SubCategprod(
                                    subcategname: cat5[index+1],
                                  )));
                    },
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(imagetry[index], fit: BoxFit.cover),
                      ),
                      Text(
                        cat5[index+1],
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
