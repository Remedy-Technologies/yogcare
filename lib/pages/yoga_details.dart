// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/models/yoga_model.dart';


class YogaDetails extends StatelessWidget {
 
  final Yogas yogas;

  const YogaDetails({super.key, required this.yogas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      
      
      floatingActionButton: FloatingActionButton(onPressed: () {},
        child: Icon(Icons.library_books),
        backgroundColor: Color.fromRGBO(53, 1, 61, 1),
      ),
      backgroundColor: Color.fromRGBO(245,245,245, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: Key(yogas.id.toString()),                //tag on both sides
                child: Image.network(yogas.img)).p16().h32(context),
        
                Column(
                    children:[ VxArc(
                      height: 15.0,
                      edge: VxEdge.TOP,
                      arcType: VxArcType.CONVEY,
        
                      child: Container(
                        color: Colors.white,
                        width: context.screenWidth,
        
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 36,),
                          child: Column(children: [
                            yogas.name.text.xl3
                            .textStyle(context.captionStyle)
                            .bold.color(Color.fromRGBO(53, 1, 61, 1)).make(),     //prod name
                             Text(
                              yogas.desc,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue
                                ),
                              ).py8(),                         //prod description
                             yogas.longdesc.text.make().py8(),
                          ]),
                        ),
                    )
                  )         
            ])
            ],
          ),
        ),
      ),
    );
  }
}