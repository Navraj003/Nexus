import 'package:flutter/material.dart';

class SupplierStats extends StatelessWidget {
  const SupplierStats ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Stats Screen'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
