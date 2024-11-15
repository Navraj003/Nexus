import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/Invoice.dart';

final _firebase = FirebaseAuth.instance;

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String naam = '';
  late String phone = '';
  late String ptaa = '';
  final CollectionReference customers =
      FirebaseFirestore.instance.collection('donatedtoandby');

  Future<void> saveDonationDetails() async {
    String uid = _firebase.currentUser!.uid;

    try {
      await customers.doc(uid).set({
        'name': naam,
        'phone': phone,
        'address': ptaa,
        'cid': uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Donation details saved successfully.")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving donation details: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 235, 235),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Donation Details',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 3, 3, 3)),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 60),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Donated BY:',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                            Text(
                              'Name: ${data['name']}',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            Text(
                              'Phone: ${data['phone']}',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            Text(
                              'Address: ${data['address']}',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Donated to:',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ),
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  naam = value!;
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Phone number',
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ),
                                keyboardType: TextInputType.phone,
                                onSaved: (value) {
                                  phone = value!;
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ),
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  ptaa = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Donation')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No donations available'));
                        }
                        final donationItems = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: donationItems.length,
                          itemBuilder: (context, index) {
                            final donation = donationItems[index];
                            final prodName = donation['proname'];
                            final imageUrlList = donation['proimages'];

                            return DonationCard(
                              prodName: prodName,
                              imageUrl: imageUrlList.isNotEmpty
                                  ? imageUrlList[0]
                                  : '',
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                color: Colors.black,
                child: OutlinedButton(
                  onPressed: () {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    saveDonationDetails();
  }
  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Invoice(
                          userData: data,
                          donationItems: [], // Add donation items as needed
                        ),
                      ),
                    );
},
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      side: const BorderSide(color: Colors.black),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class DonationCard extends StatelessWidget {
  final String prodName;
  final String imageUrl;

  const DonationCard({
    required this.prodName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2.0),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? Image.network(imageUrl, fit: BoxFit.cover)
            : null,
        title: Text(prodName),
      ),
    );
  }
}