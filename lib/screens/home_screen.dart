import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("My Application"),
      ),
      body:const Center(
        child: Text("Welcome to myApplication"),
      ),
    );
  }
}
