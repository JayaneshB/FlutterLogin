import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);


  void initState() {
    // Initialization code can go here
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: const Center(
        child: Text('This is the Messages Screen'),
      ),
    );
  }
} 