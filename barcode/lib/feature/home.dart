import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var tPoint = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('Your Total Point $tPoint')],
      ),
      
      
    );

  }
}
