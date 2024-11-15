import 'package:flutter/material.dart';

class EditBusiness extends StatelessWidget {
  const EditBusiness ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Edit Business Screen'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
