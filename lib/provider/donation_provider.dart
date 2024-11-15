import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DonationItem {
  final String name;
  final String imageUrl;

  DonationItem({
    required this.name,
    required this.imageUrl,
  });

  // Create a factory constructor to create DonationItem from Firestore document
  factory DonationItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return DonationItem(
      name: data['name'] ?? 'No Name',
      imageUrl: data['imageUrl'] ?? '', // Ensure imageUrl is fetched
    );
  }
}

class DonationProvider with ChangeNotifier {
  List<DonationItem> _donations = [];

  List<DonationItem> get donations => _donations;

  // Method to fetch donations from Firestore
  Future<void> fetchDonations() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Donations')
          .get();

      _donations = snapshot.docs
          .map((doc) => DonationItem.fromFirestore(doc))
          .toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching donations: $error");
    }
  }

  // Additional methods for adding, updating, or removing donations can go here
}
