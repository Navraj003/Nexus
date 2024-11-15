import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/searchscreen.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) =>const SearchScreen()));
      },
      child: Container(
        height: 40,
        width: 300,
        decoration: BoxDecoration(
            border: Border.all(
                color:const Color.fromARGB(199, 147, 141, 141), width: 1.4),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.search,
                    color: Color.fromARGB(173, 132, 129, 129),
                  ),
                ),
                Text(
                  'What are you looking for?',
                  style:GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(173, 132, 129, 129)),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: 60,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 5, 5, 5)),
              child: Center(
                  child: Text(
                'Search',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(252, 173, 173, 173)),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
