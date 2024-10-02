
import 'dart:convert';

import 'package:fihirana/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalamoData {
  final int faha;
  final String? hTitle;
  final String fileName;

  SalamoData({required this.faha, this.hTitle, required this.fileName});

  factory SalamoData.fromJson(Map<String, dynamic> json) {
    return SalamoData(
      faha: json['faha'],
      hTitle: json['h_title'],
      fileName: 'files/has/${json['h_id']}.html', 
    );
  }
}

class SalamoListView extends StatefulWidget {
  @override
  _SalamoListViewState createState() => _SalamoListViewState();
}

class _SalamoListViewState extends State<SalamoListView> {
  late Future<List<SalamoData>> salamoList;

  @override
  void initState() {
    super.initState();
    salamoList = _loadSalamoData();
  }

  Future<List<SalamoData>> _loadSalamoData() async {
    final String jsonString = await rootBundle.loadString('files/salamo-data.json'); 
    final List<dynamic> jsonResponse = json.decode(jsonString);
    List<SalamoData> salamoData = jsonResponse.map((data) => SalamoData.fromJson(data)).toList();

  
    salamoData.sort((a, b) => a.faha.compareTo(b.faha));

    return salamoData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SalamoData>>(
      future: salamoList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final salamoData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: salamoData.length,
              itemBuilder: (context, index) {
                final item = salamoData[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(item.hTitle ?? "🚧 Tsy anatin'ny Fihirana🚧 ",style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Text("${item.faha.toString()}", style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HtmlWebViewScreen(
                              fileName: item.fileName,
                              fTitle: item.hTitle ?? "🚧 Tsy anatin'ny Fihirana 🚧 ", 
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          );
        } else {
          return Center(child: Text('No Data'));
        }
      },
    );
  }
}

