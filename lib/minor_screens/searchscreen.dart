import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_app/screens/customer_home.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) =>const Customerhome()));
          },
        ),
        title: const CupertinoSearchTextField(),
      ),
    );
  }
}
