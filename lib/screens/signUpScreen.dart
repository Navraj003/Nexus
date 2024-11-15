import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/screens/customer_home.dart';
import 'package:nexus_app/screens/homescreen.dart';
import 'package:nexus_app/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  late String enteredemail = '';
  late String enteredpass = '';
  late String enteredname = '';
  late String enteredPhoneNumber = '';
  late String _uid;
  final _isSignUp = true;
  String _selectedRole = "Student";
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void onSubmit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isSignUp) {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: enteredemail, password: enteredpass);
        print(userCredential);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const Customerhome()));
            _uid = FirebaseAuth.instance.currentUser!.uid;


          await customers.doc(_uid).set({
          'name' :enteredname,
          'email' : enteredemail,
          'phone' : enteredPhoneNumber,
          'role':_selectedRole,
          'cid': _uid,
          'address':''
          

        });
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage = 'Authentication failed';
      if (error.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (error.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
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
                          labelText: 'Name',
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
                            return 'Please enter your name ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredname = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                          if (value == null ||
                              value.contains('@a') ||
                              value.trim().isEmpty) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredemail = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone number',
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
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10) {
                            return 'Please enter valid  mobile number';
                          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredPhoneNumber = value!;
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
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be atleast 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredpass = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Role',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 3, 3, 3)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Radio<String>(
                              value: "Student",
                              groupValue: _selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                            Text(
                              "Student",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 3, 3, 3)),
                              ),
                            ),
                          ]),
                          Row(children: [
                            Radio<String>(
                              value: "Faculty",
                              groupValue: _selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                            Text(
                              "Faculty",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 3, 3, 3)),
                              ),
                            ),
                          ]),
                          Row(children: [
                            Radio<String>(
                              value: "Staff",
                              groupValue: _selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                            Text(
                              "Staff  ",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 3, 3, 3)),
                              ),
                            ),
                          ]),
                        ],
                      )
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
                    '         Sign Up             ',
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
                        builder: (ctx) => const LoginScreen()));
                  },
                  child: Text(
                    'Already have an account? Login ',
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
