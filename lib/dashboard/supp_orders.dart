import 'package:flutter/material.dart';

class SuppOrders extends StatelessWidget {
  const SuppOrders ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Supplier Orders Screen'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
