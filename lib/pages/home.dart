// ignore_for_file: prefer_const_constructors
//import 'dart:html';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/gridmeditation.dart';
import 'package:yoga_app/pages/meditation.dart';
import 'package:yoga_app/pages/tracker.dart';
import 'package:yoga_app/pages/personaldet.dart';
import 'package:yoga_app/pages/settings.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/services.dart'; // take json
import 'dart:convert'; //json decode encode
import 'package:yoga_app/models/catalog.dart';
import 'package:yoga_app/utils/date_time.dart';

import '../utils/date_time.dart';
import '../utils/parq_check.dart';
import '../widgets/drawer.dart';
import 'yoga_details.dart';
import 'package:yoga_app/utils/routes.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final habitbox = Hive.box("Tracker_db");
  //call db
  TrackerDatabase db = TrackerDatabase();
  @override
  void initState() {
    if (habitbox.get("HABITLIST") == null) {
      db.createInitialData();
    }
    //already exist data
    else {
      db.loadData();
    }
    super.initState();
    loadData();

    db.updateDb();
  }

  void updateSet() {
    setState(() {});
    db.updateDb();
  }

  loadData() async {
    // Extracting json file
    //await Future.delayed(Duration(seconds: 2));
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["sections"]; //Only products required
    CatalogModels.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //String appName = "organizer";
    //final dummylist = List.generate(20, (index) => CatalogModels.items[0]);

    return Scaffold(
      //Velocity Xp

      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: AppDrawer(//creates menu button
          ),

      backgroundColor: context.cardColor,
      //floating button

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 5, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              Padding(
                //progress bar text
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    "Today's progress"
                        .text
                        .textStyle(GoogleFonts.sourceSansPro())
                        .size(16)
                        .make(),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5, bottom: 10), //progress bar
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LinearPercentIndicator(
                      lineHeight: 20,
                      percent: double.tryParse(habitbox.get(
                              "PERCENTAGE_SUMMARY_${todaysDateFormatted()}")) ??
                          (0.0),
                      progressColor: context.theme.unselectedWidgetColor,
                    ),
                  ],
                ),
              ),
              if (CatalogModels.items.isNotEmpty)
                CatalogList().expand()
              else
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15.0,
          ),
          child: "yogcare"
              .text
              .xl5
              .color(context.theme.buttonColor)
              .textStyle(GoogleFonts.comfortaa(fontWeight: FontWeight.bold))
              .make(),
        ), // same as Text() but easy to use
        "Creating a Healthy Lifestyle"
            .text
            .xl
            .textStyle(GoogleFonts.comfortaa(fontWeight: FontWeight.bold))
            .make()
      ],
    );
  }
}

class CatalogList extends StatefulWidget {
  const CatalogList({super.key});
  @override
  State<StatefulWidget> createState() => _CatalogListState();
}

class _CatalogListState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModels.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModels.items[index];
        // If else for diff pages
        if (catalog.id.toString() == "1") {
          return InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParqCheck())),
              child: CatalogItem(catalog: catalog));
        }
        if (catalog.id.toString() == "2") {
          return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackerPage(),
                  )),
              child: CatalogItem(catalog: catalog));
        } else {
          return InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MeditationGrid())),
              child: CatalogItem(catalog: catalog));
        }
      },
    ).py12();
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  const CatalogItem({super.key, required this.catalog});
  @override
  Widget build(BuildContext context) {
    return VxBox(
            //same as container but easy

            child: Row(
      children: [
        Hero(
          tag: Key(catalog.id.toString()), //tag on both sides
          child: Container(
            child: Image.network(catalog.img) //prod image
                .box
                .p12
                .roundedLg
                .square(100)
                .color(context.cardColor)
                .make()
                .p16()
                .w32(context),
          ),
        ),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              catalog.name.text
                  .textStyle(GoogleFonts.sourceSansPro())
                  .bold
                  .color(context.theme.buttonColor)
                  .size(18)
                  .make(), //prod name
              catalog.desc.text.make().py8(), //prod description
            ]))
      ],
    ))
        .border(color: context.theme.primaryColor)
        .color(context.canvasColor)
        .roundedLg
        .square(138)
        .make()
        .py16();
  }
}
