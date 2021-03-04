import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Home'),
      ),
      body: Center(
        child: Text('HOME PAGE'),
      ),

    );
  }
}