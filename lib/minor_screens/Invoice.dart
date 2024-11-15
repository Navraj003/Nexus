import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/Donation_details.dart';

class Invoice extends StatefulWidget {
  final Map<String, dynamic> userData;
  final List<Map<String, dynamic>> donationItems;

  const Invoice({
    super.key,
    required this.userData,
    required this.donationItems,
  });

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final TextEditingController naamController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final CollectionReference donatedTo =
      FirebaseFirestore.instance.collection('donatedto');

  void saveDonationDetails() async {
    final naam = naamController.text;
    final phone = phoneController.text;
    final address = addressController.text;

    // Save donation details to 'donatedto' collection
    await donatedTo.add({
      'name': naam,
      'phone': phone,
      'address': address,
      'donatedBy': widget.userData['name'],
      'donatedByPhone': widget.userData['phone'],
      'donatedByAddress': widget.userData['address'],
      'donationItems': widget.donationItems
          .map((item) => {'name': item['name'], 'imageUrl': item['imageUrl']})
          .toList(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Donation details saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
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
              'Invoice',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 100),
            child: Column(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Name: ${widget.userData['name']}',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Phone: ${widget.userData['phone']}',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Address: ${widget.userData['address']}',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Donated to:',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: donatedTo.snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Text('No donation details available.');
                            }
                            final latestDonation = snapshot.data!.docs.last;
                            final donationData = latestDonation.data() as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${donationData['name']}',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Phone: ${donationData['phone']}',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Address: ${donationData['address']}',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.donationItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.donationItems[index];
                      return DonationCard(
                        prodName: item['name'],
                        imageUrl: item['imageUrl'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
