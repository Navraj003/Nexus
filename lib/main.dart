import 'package:flutter/material.dart';
import 'package:nexus_app/provider/cart_provider.dart';
import 'package:nexus_app/provider/donation_provider.dart';
import 'package:nexus_app/provider/wishlist_provider.dart';
import 'package:nexus_app/screens/LandingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>DonationProvider (),),
      ChangeNotifierProvider(create: (_)=> Cart(),),
      ChangeNotifierProvider(create: (context) => Wish()),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 3, 2, 2)),
      ),
      home:const LadingSceeen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
