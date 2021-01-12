import 'package:flutter/material.dart';
import 'package:pizza_ap/screens/pizza_order_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PizzaOrderHome(),
    );
  }
}


