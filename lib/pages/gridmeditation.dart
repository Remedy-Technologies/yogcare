import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/meditation.dart';

import '../main.dart';
import '../utils/routes.dart';

class MeditationGrid extends StatefulWidget {
  const MeditationGrid({super.key});

  @override
  State<MeditationGrid> createState() => _MeditationGridState();
}

class _MeditationGridState extends State<MeditationGrid> {
 
  //reference the hive box
  final meditationbox = Hive.box("Meditation_db");
  //list of Parq
  MeditationDatabase db = MeditationDatabase();


  void selectMeditation(int num) {
    if (num == 1) {
      setState(() {
        db.counter=1;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeditationPage()),
      );
    } else if (num == 2) {
      setState(() {
        db.counter=2;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeditationPage()),
      );
    } else if (num == 3) {
      setState(() {
        db.counter=3;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeditationPage()),
      );
    } else {
      setState(() {
        db.counter=4;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeditationPage()),
      );
    }
    db.updateDbMed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.cardColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const MeditationHeader(),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: SizedBox(
                  height: 800,
                  child: GridView.count(
                    crossAxisCount: 2,
                    // padding: EdgeInsets.all(10),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectMeditation(1);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/med-1.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Chill",
                                      style: GoogleFonts.josefinSans(
                                          textStyle: const TextStyle(
                                              fontSize: 28,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 225))),
                                    )),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectMeditation(2);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/med-2.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.center,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Energy',
                                      style: GoogleFonts.josefinSans(
                                          textStyle: const TextStyle(
                                              fontSize: 28,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 225))),
                                    )),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectMeditation(3);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/med-3.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Calm",
                                      style: GoogleFonts.josefinSans(
                                          textStyle: const TextStyle(
                                              fontSize: 28,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 225))),
                                    )),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectMeditation(4);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/med-4.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Relax",
                                      style: GoogleFonts.josefinSans(
                                          textStyle: const TextStyle(
                                              fontSize: 28,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 225))),
                                    )),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MeditationHeader extends StatelessWidget {
  const MeditationHeader({super.key});

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
          child: "Meditation"
              .text
              .xl4
              .color(context.theme.buttonColor)
              .textStyle(GoogleFonts.comfortaa(fontWeight: FontWeight.bold))
              .make(),
        ), // same as Text() but easy to use
        "Relax and meditate with music"
            .text
            .xl
            .textStyle(GoogleFonts.comfortaa(fontWeight: FontWeight.bold))
            .make()
      ],
    );
  }
}
