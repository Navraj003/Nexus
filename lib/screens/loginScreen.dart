import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/screens/customer_home.dart';
import 'package:nexus_app/screens/homescreen.dart';
import 'package:nexus_app/screens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  late String savedemail ;
  late String savedpassword ;
  String _selectedtask = "Donate";

  void onSubmit() async{
    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }
    if (valid) {
      _form.currentState!.save();
      
      try {
      final userCredential =   await  _firebase.signInWithEmailAndPassword(
          email: savedemail, password: savedpassword);
          print("Logged in: $userCredential");
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Customerhome()));
      } on FirebaseAuthException catch (error) {
        String errorMessage = 'Login failed';
      if (error.code == 'user-not-found') {
        errorMessage = 'No user found for this email.';
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/image-removebg-preview (4).png',
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 3, 3, 3)),
                              borderRadius: BorderRadius.zero),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.zero),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.zero),
                        ),
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        onSaved: (value) {
                          savedemail = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.zero),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.zero),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.zero),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                          validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                        onSaved: (value) {
                          savedpassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: onSubmit,
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      side: const BorderSide(color: Colors.black),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: Text(
                    '         Login In            ',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 3, 3, 3)),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SignUpScreen()));
                  },
                  child: Text(
                    "Don't have an account? Sign Up ",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 3, 3, 3)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
