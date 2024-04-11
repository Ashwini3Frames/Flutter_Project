import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_application/screens/home_screen.dart';
class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState()=>_SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_)=>const HomeScreen(),
      )

      );
    });
  }
  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
          colors:[Colors.blue,Colors.purple],
          begin:Alignment.topRight,
          end:Alignment.bottomLeft,
          ),
        ),
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.edit,
        size:30,
        color:Colors.white
        ),
        SizedBox(height:20),
        Text("Flutter Tips",style:TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.white,
          fontSize: 32,
        ),)
      ],
     ),
      ),
    );
  }
}