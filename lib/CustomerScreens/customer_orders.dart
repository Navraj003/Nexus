import 'package:flutter/material.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Customer Orders Screen'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
