
import 'dart:convert';

import 'package:fihirana/search.dart';
import 'package:fihirana/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SongListScreen extends StatefulWidget {
  final int fId;
  final String? fTitle;

  SongListScreen({required this.fId, this.fTitle = ''});

  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  List songs = [];

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  Future<void> loadSongs() async {
    final String response = await rootBundle.loadString('files/hira-data.json');
    final data = await json.decode(response);

    setState(() {
    
      songs = data.where((song) => song['f_id'] == widget.fId).toList();
      songs.sort((a, b) => a['f_page'].compareTo(b['f_page']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fTitle!.isNotEmpty ? widget.fTitle! : 'Songs'),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return Column(
              
              children: [
                
                ListTile(
                  title: Text(
                    songs[index]['h_title'] ?? "Tsy anatin'ny fihirana",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'p.${songs[index]['f_page']}',
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HtmlWebViewScreen(
                          fileName: 'files/has/${songs[index]['h_id']}.html',
                          fTitle: songs[index]['h_title'],
                        ),
                      ),
                    );
                  },
                ),
                Divider()
              ],
            );
          },
        ),
      ),

          floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,onPressed: (){

        
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        

      },child: Icon(Icons.search,size: 30,color: Colors.white,))


    );
  }
}