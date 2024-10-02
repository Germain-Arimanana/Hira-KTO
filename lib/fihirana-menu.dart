



import 'dart:convert';

import 'package:fihirana/songlistScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final String response =
        await rootBundle.loadString('files/android_fihirana.json');
    final data = await json.decode(response);
    setState(() {
      categories = data;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
           
            return Column(
              children: [
                
                Card(
                 borderOnForeground: true,
                  elevation: 4,
                  child: Column(
                    children: [
                      //Image.asset("files/icons/hira.jpeg",width: 300,),
                      ListTile(
                        title: Text(categories[index]['f_title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        subtitle: Text(categories[index]['f_description'],style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                       
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongListScreen(
                                  fId: categories[index]['id'], 
                                  fTitle: categories[index]['f_title']),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,)
              ],
            );
          },
        )
    );
  }}






