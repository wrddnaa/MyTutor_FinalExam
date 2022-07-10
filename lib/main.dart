import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_tutor/views/loginscreen.dart';
void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,

      ),
      home: const MySplashScreen(),
    );
  }
}
  
class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

@override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (content) => const LoginScreen())));
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
        child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const[
                
                CircularProgressIndicator(),
                
                Text("MyTutor", style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ]
              )
            )
          ]
        )
      )
    )
  );   
}}