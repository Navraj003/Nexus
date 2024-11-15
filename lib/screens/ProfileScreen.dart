import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/CustomerScreens/Wishlist.dart';
import 'package:nexus_app/CustomerScreens/customer_orders.dart';
import 'package:nexus_app/screens/cartscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus_app/screens/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({super.key,required this.documentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const  Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 140,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity:
                                    constraints.biggest.height <= 120 ? 1 : 0,
                                child: Text(
                                  'Account',
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 3, 3, 3),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            background: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 16, 16, 16),
                                Color.fromARGB(255, 58, 54, 52)
                              ])),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 30),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('lib/assets/guest.jpg'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        data['name'].toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 3, 3, 3),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Center(
                                      child: Text(
                                        'Cart',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CartScreenState()));
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Center(
                                      child: Text(
                                        'Orders',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 3, 3, 3),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CustomerOrders()));
                                  },
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 3, 3, 3),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Center(
                                      child: Text(
                                        'Wishlist',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                  WishListScreen()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const ProfileHeaderLabel(
                          headerLabel: 'Account Info',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                RepeatedTileWidget(
                                    icon: Icons.email,
                                    onPressed: () {},
                                    subtitle: data['email'],
                                    title: 'E-mail Address'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    thickness: 1,
                                  ),
                                ),
                                RepeatedTileWidget(
                                    icon: Icons.phone,
                                    onPressed: () {},
                                    subtitle: data['phone'],
                                    title: 'Phone number'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    thickness: 1,
                                  ),
                                ),
                                RepeatedTileWidget(
                                    icon: Icons.location_city,
                                    onPressed: () {},
                                    subtitle: data['address'],
                                    title: 'Address'),
                              ],
                            ),
                          ),
                        ),
                        const ProfileHeaderLabel(
                            headerLabel: 'Account Settings'),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                RepeatedTileWidget(
                                  title: 'Edit Profile',
                                  subtitle: '',
                                  icon: Icons.edit,
                                  onPressed: () {},
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    thickness: 1,
                                  ),
                                ),
                                InkWell(
                                    child: RepeatedTileWidget(
                                        icon: Icons.lock,
                                        onPressed: () {},
                                        title: 'Cange Password')),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    thickness: 1,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: RepeatedTileWidget(
                                        icon: Icons.logout,
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const LoginScreen()));
                                        },
                                        title: 'Logout')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          );
        }

        return Text("loading");
      },
    );
  }
}

class RepeatedTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedTileWidget(
      {super.key,
      required this.icon,
      this.onPressed,
      this.subtitle = '',
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 3, 3, 1),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            )),
        subtitle: Text(subtitle,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 18, 18, 17),
              fontSize: 15,
              fontWeight: FontWeight.normal,
            )),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 3, 3, 1),
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
