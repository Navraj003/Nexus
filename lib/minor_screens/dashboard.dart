import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/dashboard/edit_business.dart';
import 'package:nexus_app/dashboard/manage_prods.dart';
import 'package:nexus_app/dashboard/mystore.dart';
import 'package:nexus_app/dashboard/suppStatistics.dart';
import 'package:nexus_app/dashboard/supp_balance.dart';
import 'package:nexus_app/dashboard/supp_orders.dart';

List<String> lables = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statistics',
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.monetization_on,
  Icons.show_chart
];
List<Widget> pages =const [
  MyStore(),
  SuppOrders(),
  EditBusiness(),
  ManageProducts(),
  BalanceScreen(),
  SupplierStats()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 3, 3, 3)),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            color: const Color.fromARGB(255, 3, 3, 3),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) =>  pages[index]));
              },
              child: Card(
                color: const Color.fromARGB(255, 3, 3, 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(lables[index].toUpperCase(),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: 2),
                        ))
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
