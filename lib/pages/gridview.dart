// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';                    // take json
import 'dart:convert';                                     //json decode encode


import 'package:yoga_app/models/catalog.dart';
import 'package:yoga_app/widgets/drawer.dart';
//import 'package:velocity_x/velocity_x.dart';
//import '../widgets/item_widget.dart';




class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async{                                           // Extracting json file
    await Future.delayed(Duration(seconds: 2));
    var catalogJson =await rootBundle.loadString("assets/files/catalog.json");
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["products"];               //Only products required
    CatalogModels.items = List.from(productsData)
      .map<Item>((item) => Item.fromMap(item))
      .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      String appName = "organizer";
      final dummylist = List.generate(20, (index) => CatalogModels.items[0]);

    return Scaffold(                                 //AppBar
      appBar: AppBar(       
        title: Text("Sample Application", style: TextStyle(color: Colors.deepPurple),),                                           
      ),

      drawer: AppDrawer(                              //creates menu button  
      ),

      body: Padding(                                        
        padding: const EdgeInsets.all(16.0),
        child: (CatalogModels.items.isNotEmpty)?  
          GridView.builder(                                                       //GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(              //no of objects in row
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,                                               
              ),  

            itemBuilder: (context, index){
             final item =  CatalogModels.items[index];
              return Card(             
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: GridTile(
                  
                  header: Container(                                            //header
                   decoration: BoxDecoration(
                     color: Colors.deepPurple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Text(item.name, style: TextStyle(color: Colors.white),)
                    ),   

                  child: Image.network(item.img),                               // ignore: sort_child_properties_last

                  footer: Container(                                            //footer
                    decoration: BoxDecoration(
                      color: Colors.black
                      ),                    
                    padding: EdgeInsets.all(12),
                      child: Text(
                        "\$${item.price}",
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,                               
                      ),
                    ),
                  ),
                  )
                );
            },
            itemCount: CatalogModels.items.length,
            )
               
        :Center(
          child: CircularProgressIndicator(),
        ),
      )     
    );
  }
}
