// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';
import '../widgets/drawer.dart';

class HomeDetails extends StatelessWidget {
 
  final Item catalog;

  const HomeDetails({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      
      
      floatingActionButton: FloatingActionButton(onPressed: () {},
        child: Icon(CupertinoIcons.cart),
        backgroundColor: Color.fromRGBO(53, 1, 61, 1),
      ),
      backgroundColor: Color.fromRGBO(245,245,245, 1),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),                //tag on both sides
              child: Image.network(catalog.img)).p16().h32(context),

              Expanded(
                  child: VxArc(
                    height: 15.0,
                    edge: VxEdge.TOP,
                    arcType: VxArcType.CONVEY,

                    child: Container(
                      color: Colors.white,
                      width: context.screenWidth,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 36,),
                        child: Column(children: [
                          catalog.name.text.xl3
                          .textStyle(context.captionStyle)
                          .bold.color(Color.fromRGBO(53, 1, 61, 1)).make(),     //prod name
                          catalog.desc.text.xl.make().py8(),                         //prod description
                          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate".text.textStyle(context.captionStyle).make().py16(),
                        ]),
                      ),
                  )
                )         
              )
          ],
        ),
      ),
    );
  }
}