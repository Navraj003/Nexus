import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/screens/loginScreen.dart';




class LadingSceeen extends StatefulWidget {
  const LadingSceeen({super.key});

  @override
  State<LadingSceeen> createState() => _LadingSceeenState();
}

class _LadingSceeenState extends State<LadingSceeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/Screenshot 2024-10-26 204123.png'),
            Text(
              'Nexus  ',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 3, 3, 3)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Sell, Buy , Business - all at One-Stop  ',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 3, 3, 3)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()));
              },
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  side: const BorderSide(color: Colors.black),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              child: Text(
                '           Explore           ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 3, 3, 3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
