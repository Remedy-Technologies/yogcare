import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/db/db.dart';


class MeditationPage extends StatefulWidget {
  MeditationPage({super.key,});
  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  final audioplayer = AudioPlayer();
  bool isPlaying = false;
  bool isShow = false;
  int counter=0;
  int x=0;
  String imgpath="";

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  //reference the hive box
  final meditationbox = Hive.box("Meditation_db");
  //list of Parq
  MeditationDatabase db = MeditationDatabase();


  @override
  void initState() { 

    if (meditationbox.get("COUNTMED") == null) {
      db.createInitialMed();
      counter=db.counter;
    }
    //already exist data
    else {
      db.loadDataMed();
      counter=db.counter;
    }
    db.updateDbMed();
    super.initState();

    setAudio();
    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioplayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
      isShow = true;
    });

    audioplayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });

  }

  Future setAudio() async {
    //Repeat song when completed
    audioplayer.setReleaseMode(ReleaseMode.loop);

    if(counter==1){
      String url =
        "https://github.com/Remedy-Technologies/yogcare-app-data/raw/master/Meydan-Freezing-but-warm.mp3";
    //audioplayer.setSourceUrl(url);
    audioplayer.setSource(UrlSource(url));
    }
    else if(counter==2){
      String url =
        "https://github.com/Remedy-Technologies/yogcare-app-data/raw/master/aumom-namah-shivaya-mantra-chants-432-hz-8940.mp3";
    //audioplayer.setSourceUrl(url);
    audioplayer.setSource(UrlSource(url));
    }
    else if(counter==3){
      String url =
        "https://github.com/Remedy-Technologies/yogcare-app-data/raw/master/scott-buckley-jul.mp3";
    //audioplayer.setSourceUrl(url);
    audioplayer.setSource(UrlSource(url));
    }
    else{
      String url =
        "https://github.com/Remedy-Technologies/yogcare-app-data/raw/master/mantra-om-for-meditation.mp3";
    //audioplayer.setSourceUrl(url);
    audioplayer.setSource(UrlSource(url));
    }

   
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  String chooseImage(){
    if(counter==1){
      return "assets/images/med-1.jpg";
    }
    else if(counter==2){
      return "assets/images/med-2.jpg";
    }
    else if(counter==3){
      return "assets/images/med-3.jpg";
    }
    else{
      return "assets/images/med-4.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.cardColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Meditation".text.xl2.color(context.primaryColor).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                //Image
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    // ignore: sort_child_properties_last
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          
                          chooseImage()
                          )),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.cardColor,
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              offset: Offset(-5, 5)),
                          BoxShadow(
                              color: context.canvasColor,
                              blurRadius: 15,
                              offset: const Offset(5, -5)),
                        ]),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Text(
                  //Text
                  "MEDITATION MUSIC",
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                        fontSize: 24,
                        color: context.primaryColor,
                        letterSpacing: 5),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Relax with a deep state of meditation",
                style: TextStyle(fontSize: 14, color: context.primaryColor),
              ),

              Padding(
                //Progress Bar
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Slider(
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: ((value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioplayer.seek(position);

                    await audioplayer.resume();
                  }),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration - position)),
                  ],
                ),
              ),

              //SizedBox(height: 10,),

              Visibility(
                  visible: !isShow,
                  child: const CircularProgressIndicator(color: Colors.purple)),

              Visibility(
                visible: isShow,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: context.theme.splashColor.withOpacity(0.8)),
                  child: InkWell(
                    onTap: () async {
                      if (isPlaying) {
                        await audioplayer.pause();
                      } else {
                        await audioplayer.resume();
                      }
                    },
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(position.inHours);
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return [if (position.inHours > 0) hours, minutes, seconds].join(':');
  }
}