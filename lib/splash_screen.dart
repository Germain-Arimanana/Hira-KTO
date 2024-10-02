

import 'package:fihirana/homepage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  
  

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

   
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //backgroundColor: Colors.white, // Set splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Image.asset('files/icons/logo.png',width: 300,),SizedBox(height: 30,),
            SizedBox(height: 20,),
            CircularProgressIndicator(color:const Color.fromARGB(255, 152, 139, 21) )
            
          ],
        ),
         // Splash screen image
      ),
    );
  }
}
