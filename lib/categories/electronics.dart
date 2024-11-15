import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/subcat.dart';
import 'package:nexus_app/categories/categ_list.dart';

List<String> imagetry = [
    'lib/assets/electronics/electronics0.jpg',
    'lib/assets/electronics/electronics1.jpg',
    'lib/assets/electronics/electronics2.jpg',
    'lib/assets/electronics/electronics3.jpg',
    'lib/assets/electronics/electronics4.jpg',
    'lib/assets/electronics/electronics5.jpg',
    'lib/assets/electronics/electronics6.jpg',
    'lib/assets/electronics/electronics7.jpg',
    'lib/assets/electronics/electronics8.jpg',
    'lib/assets/electronics/electronics9.jpg',
    'lib/assets/electronics/electronics10.jpg',
    'lib/assets/electronics/electronics11.jpg',
    'lib/assets/electronics/electronics12.jpg',
    'lib/assets/others-icon-13.jpg',
    
];

class Electronics extends StatelessWidget {
  const Electronics({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Electronics',
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
                                    subcategname: cat1[index+1],
                                  )));
                    },
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(imagetry[index], fit: BoxFit.cover),
                      ),
                      Text(
                        cat1[index+1],
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
