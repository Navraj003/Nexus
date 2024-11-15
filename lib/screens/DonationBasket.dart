import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/minor_screens/Donation_details.dart';


class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Donation').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No donations available'));
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
                imageUrl: imageUrlList.isNotEmpty ? imageUrlList[0] : '',
              );
            },
          );
        },
      ),
      floatingActionButton: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Donation').snapshots(),
        builder: (context, snapshot) {
          final hasItems = snapshot.hasData && snapshot.data!.docs.isNotEmpty;
          return FloatingActionButton.extended(
            onPressed: hasItems
                ? () {
                    // Navigate to the donation details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>DonationDetails()),
                    );
                  }
                : null, // Disable button if there are no items
            label: Text('PROCEED',style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 253, 253, 253),
      ),
    ),),
            backgroundColor: hasItems ? Colors.black : Colors.grey,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: 50,
                height: 80,
                fit: BoxFit.cover,
              )
            : Icon(Icons.image, size: 50),
        title: Text(prodName),
        subtitle: Text('Donation Item'),
      ),
    );
  }
}

