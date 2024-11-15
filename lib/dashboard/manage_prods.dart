import 'package:flutter/material.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Manage Products'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
