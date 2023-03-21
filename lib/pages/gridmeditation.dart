import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/routes.dart';

class MeditationGrid extends StatefulWidget {
  const MeditationGrid({super.key});

  @override
  State<MeditationGrid> createState() => _MeditationGridState();
}

class _MeditationGridState extends State<MeditationGrid> {
  //final List<String> _listItem = [
  // "assets/images/med_back.jpg",
  // "assets/images/med_back.jpg",
  // "assets/images/med_back.jpg",
  // "assets/images/med_back.jpg",
  //];

  void selectMeditation(int num) {
    if (num == 1) {
      Navigator.pushNamed(context, Myroutes.meditationRoute);
    } else if (num == 2) {
      Navigator.pushNamed(context, Myroutes.meditationRoute);
    } else if (num == 3) {
      Navigator.pushNamed(context, Myroutes.meditationRoute);
    } else {
      Navigator.pushNamed(context, Myroutes.meditationRoute);
    }
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
                          selectMeditation(1);
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
                          selectMeditation(1);
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
                          selectMeditation(1);
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
