


import 'dart:convert';

import 'package:fihirana/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteFiles = [];
  List<Map<String, dynamic>> allSongsData = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadHiraData();
  }

  
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteFiles = prefs.getStringList('favorites') ?? [];
    });
  }

 
  Future<void> _loadHiraData() async {
    final String jsonString = await rootBundle.loadString('files/hira-data.json'); 
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      allSongsData = jsonResponse.map((data) => data as Map<String, dynamic>).toList();
      _sortFavoritesByPage();
    });
  }

 
  void _sortFavoritesByPage() {
    favoriteFiles.sort((a, b) {
      final hIdA = a.split('/').last.split('.').first;
      final hIdB = b.split('/').last.split('.').first;

     
      final songDataA = allSongsData.firstWhere(
        (data) => data['h_id'].toString() == hIdA,
        orElse: () => {'f_page': 0},
      );
      final songDataB = allSongsData.firstWhere(
        (data) => data['h_id'].toString() == hIdB,
        orElse: () => {'f_page': 0},
      );

      return songDataA['f_page'].compareTo(songDataB['f_page']);
    });
  }

 
  Future<void> _removeFromFavorites(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteFiles.remove(fileName);
      prefs.setStringList('favorites', favoriteFiles);
      _sortFavoritesByPage(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: favoriteFiles.isEmpty
          ? Center(child: Text('No favorites added yet.'))
          : ListView.builder(
              itemCount: favoriteFiles.length,
              itemBuilder: (context, index) {
                final fileName = favoriteFiles[index];
                final hId = fileName.split('/').last.split('.').first; 

               
                final songData = allSongsData.firstWhere(
                  (data) => data['h_id'].toString() == hId,
                  orElse: () => {'h_title': 'Unknown', 'f_page': 'No page info'},
                );

                return Card(
                  child: ListTile(
                    title: Text(songData['h_title'] ?? 'No Title'),
                    subtitle: Text('Page ${songData['f_page'] ?? 'No Page'}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeFromFavorites(fileName),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HtmlWebViewScreen(
                            fileName: fileName,  
                            fTitle: songData['h_title'] ?? 'No Title',  
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
