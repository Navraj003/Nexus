import 'package:flutter/material.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('My Store'),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.back_hand)),
      ),
    );
  }
}
