
import 'dart:convert';

import 'package:fihirana/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlWebViewScreen extends StatefulWidget {
  final String fileName;
  final String fTitle;

  HtmlWebViewScreen({required this.fileName, required this.fTitle});

  @override
  _HtmlWebViewScreenState createState() => _HtmlWebViewScreenState();
}

class _HtmlWebViewScreenState extends State<HtmlWebViewScreen> {
  late WebViewController _controller;
  String? htmlContent;
  bool isFavorite = false;
  List<String> favoriteFiles = [];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    _loadHtmlFromAssets();
    _loadFavorites();
  }

  Future<void> _loadHtmlFromAssets() async {
    try {
      String fileContent = await rootBundle.loadString(widget.fileName);
      setState(() {
        htmlContent = Uri.dataFromString(
          fileContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString();
        _controller.loadRequest(Uri.parse(htmlContent!));
      });
    } catch (e) {
      print("Error loading HTML file: $e");
    }
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteFiles = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavorite = favoriteFiles.contains(widget.fileName);
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (isFavorite) {
        favoriteFiles.remove(widget.fileName);
      } else {
        favoriteFiles.add(widget.fileName);
      }
      isFavorite = !isFavorite;
      prefs.setStringList('favorites', favoriteFiles);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      
      AppBar(
      
      title:Text(widget.fTitle,softWrap: false,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
        //bottom: PreferredSize(preferredSize: Size(width, height), child: Text(widget.fTitle,softWrap: true,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow),textAlign: TextAlign.center,),),
        //toolbarHeight: 120,
        /*
        title: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Text("Fihirana Katolika",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        ),
        
        */ // Display the f_title in the AppBar
        actions: [
          

          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border ,
                color: isFavorite ? Colors.yellow : Colors.white,
                size: 30,
              ),
              onTap: _toggleFavorite,
            ),
          ),

             



        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: WebViewWidget(controller: _controller),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,onPressed: (){

        
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        

      },child: Icon(Icons.search,size: 30,color: Colors.white,))
    );
  }
}

