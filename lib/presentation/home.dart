import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String email;
  const Home({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('Home - $email'))),
    );
  }
}
