import 'package:fihirana/splash_screen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fihirana',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey), 
          filled: true,
          fillColor: Colors.grey[100], 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none, 
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          //prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
        ),

        
        appBarTheme: AppBarTheme(centerTitle: true,titleTextStyle:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),iconTheme: IconThemeData(color: Colors.white),backgroundColor: Colors.red),
        //iconButtonTheme:IconButtonThemeData(style: ButtonStyle(iconColor:kDefaultIconDarkColor)) ,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor:Colors.white,elevation: 6),
        primaryColor: Colors.black,
        cardTheme: CardTheme(color: Colors.white),
        dialogTheme: DialogTheme(backgroundColor: Colors.white),
         iconTheme: IconThemeData(color: Colors.black),
         bottomAppBarTheme: BottomAppBarTheme(color: Colors.white)
        
      ),
      darkTheme: ThemeData.dark().copyWith(
       scaffoldBackgroundColor: Colors.black,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
        appBarTheme: AppBarTheme(elevation: 4,titleTextStyle:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),iconTheme: IconThemeData(color: Colors.white),backgroundColor: Colors.black),
        primaryColor: Colors.white,
        cardTheme: CardTheme(color: const Color.fromARGB(255, 32, 31, 31)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor:const Color.fromARGB(255, 24, 24, 24) ),
       
        dialogTheme: DialogTheme(backgroundColor: Color.fromARGB(255, 29, 29, 29)),
        iconTheme: IconThemeData(color: Colors.white),
        ),
       themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



































