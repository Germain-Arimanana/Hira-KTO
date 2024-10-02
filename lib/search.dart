


import 'dart:async';
import 'dart:convert';

import 'package:fihirana/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List categories = [];
  List songs = [];
  List searchResults = [];
  Map<int, String> categoryMap = {}; 
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }


  Future<void> loadJsonData() async {
    try {
      final String categoryResponse = await rootBundle.loadString('files/android_fihirana.json');
      final String songResponse = await rootBundle.loadString('files/hira-data.json');

      final List categoryData = json.decode(categoryResponse);
      final List songData = json.decode(songResponse);

      setState(() {
        categories = categoryData.map((category) => {
          'f_title': (category['f_title'] ?? '').toLowerCase(),
          'f_description': (category['f_description'] ?? '').toLowerCase(),
          'id': category['id'],
        }).toList();

       
        categoryMap = {for (var category in categoryData) category['id']: category['f_title']};

        songs = songData.map((song) => {
          'h_title': (song['h_title'] ?? '').toLowerCase(),
          'f_page': song['f_page'],
          'h_id': song['h_id'],
          'f_id': song['f_id'],
        }).toList();
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        search(query);
      } else {
        setState(() {
          searchResults = [];
        });
      }
    });
  }

  void search(String query) {
    String normalizedQuery = query.toLowerCase();

    setState(() {
      searchResults = [];

     
      searchResults.addAll(categories.where((category) =>
        category['f_title'].contains(normalizedQuery) ||
        category['f_description'].contains(normalizedQuery)));

     
      searchResults.addAll(songs.where((song) =>
        song['h_title'].contains(normalizedQuery) ||
        song['f_page'].toString().contains(normalizedQuery)));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }


  void _clearSearch() {
    _searchController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 10),
         Padding(
           padding: const EdgeInsets.only(right: 40),
           child: TextField(
                 controller: _searchController,
                 decoration: InputDecoration(
                   hintText: 'Tadiavo ny hira...',
                  // hintStyle: TextStyle(color: Colors.grey[600]),
                   filled: true,
                   //fillColor: Colors.white,
                   
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide.none,),
                   
                   contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                   //prefixIcon: Icon(Icons.search,size: 35,),
                   suffixIcon: IconButton(icon: Icon(Icons.clear, ),onPressed: _clearSearch,)
                  
                 ),
                 onChanged: _onSearchChanged,

                 
               ),
         )

            /*
            TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Tadiavo: lohateny na pejy'),
              onChanged: _onSearchChanged,
            ),

            */
          ],
        ),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: searchResults.isEmpty
            ? Center(
                child: Icon(
                  _searchController.text.isEmpty ? CupertinoIcons.search : CupertinoIcons.xmark,
                  size: 200,
                  color: const Color.fromARGB(255, 162, 161, 161),
                ),
              )
            : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var result = searchResults[index];
                  String? categoryTitle;
        
                 
                  if (result['f_id'] != null) {
                    categoryTitle = categoryMap[result['f_id']] ?? "Tsy anatin'ny Fihirana";
                  }
        
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          trailing: Icon(CupertinoIcons.arrow_right_square,color: Colors.red,size: 25,),
                          title: Text(result['f_title'] ?? result['h_title'],style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: categoryTitle != null && result['f_page'] != null
                              ? Text('$categoryTitle   Pejy: ${result['f_page']}')
                              : result['f_description'] != null
                                  ? Text(result['f_description'] ?? '')
                                  : Text('Pejy: ${result['f_page']}'),
                          onTap: () {
                            if (result['h_id'] != null) {
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HtmlWebViewScreen(
                                    fileName: 'files/has/${result['h_id']}.html',
                                    fTitle: result['h_title'], 
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 5,)
                    ],
                  );
                },
              ),
      ),
    );
  }
}
