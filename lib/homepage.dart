
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:fihirana/favorite.dart';
import 'package:fihirana/fihirana-menu.dart';
import 'package:fihirana/gthub.dart';
import 'package:fihirana/info-page.dart';
import 'package:fihirana/salamo.dart';
import 'package:fihirana/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    CategoryScreen(),
    SalamoListView(),
    FavoritePage(),
    
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Fihirana Katolika',style: TextStyle(fontSize: 30),),
        elevation: 4,
       
      ),
      drawer: Drawer(
      
        child: ListView(
          children: [
            Container(
           // decoration: BoxDecoration(color: Colors.red) ,
              child: Row(
              children: [
                
                Image.asset("files/icons/logo.png",width: 100,),
                //SizedBox(width: 10,),
                Text("Fihirana Katolika",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            )),
            Divider(),
            ListTile(title: Text("Momba ny Rindrankajy"),leading: Icon(BootstrapIcons.info_square),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>infoPage()));},),
            ListTile(title: Text("Github"),leading: Icon(BootstrapIcons.github),onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPage(url: "https://github.com/Germain-Arimanana?tab=repositories",)));
            },)
          ],
        ),
      ),
       body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Fihirana',
          ),
           
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.music_note_list),
            label: 'Salamo',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.star_fill),
            label: 'Tahiry',
          ),
          
         
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        iconSize: 30,
        selectedLabelStyle: TextStyle(fontSize: 15),
        unselectedLabelStyle: TextStyle(fontSize: 15),
      ),
      
floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,onPressed: (){

        
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        

      },child: Icon(Icons.search,size: 30,color: Colors.white,))
       

    );
    
  }
}
