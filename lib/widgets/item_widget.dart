import 'package:flutter/material.dart';

import '../models/catalog.dart';

class ItemWidget extends StatelessWidget {
  

  final Item item;

  const ItemWidget({Key ?key, required this.item})                         //constructor
    :  
      super(key: key);                             

  @override
  Widget build(BuildContext context) {

    return Card(
       
      child: ListTile(                                                        //returns list
        onTap: (){        
        },    
        leading: Image.network(item.img),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text("\$${item.price}",
          textScaleFactor: 1.3,
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,        
            ),
          ),
      ),
    );
  }
}