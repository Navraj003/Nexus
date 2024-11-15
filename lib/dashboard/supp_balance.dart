import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Balance Screen'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
