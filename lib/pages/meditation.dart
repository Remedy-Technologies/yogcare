import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  final audioplayer = AudioPlayer();

  bool isPlaying = false;
  double value = 0;
  //Duration duration=Duration.zero;
  //Duration position=Duration.zero;

  //duration setting
  Duration? duration = const Duration(seconds: 0);

  // function to initialize music
  void initPlayer() async {
    await audioplayer.setSourceUrl(
        "https://github.com/Remedy-Technologies/yogcare-app-data/raw/main/aumom-namah-shivaya-mantra-chants-432-hz-8940.mp3");
    duration = await audioplayer.getDuration();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioplayer.dispose();
    super.dispose();
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
                        child: Image.asset("assets/images/med_back.jpg")),
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
                  style: GoogleFonts.aBeeZee(
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
                  max: duration!.inSeconds.toDouble(),
                  value: value,
                  onChanged: ((newvalue) {
                    value = newvalue;
                  }),
                  onChangeEnd: (newValue) async {
                    setState(() {
                      value = newValue;
                    });
                    audioplayer.pause();
                    await audioplayer.seek(Duration(seconds: newValue.toInt()));
                    if (isPlaying) {
                      await audioplayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioplayer.resume();
                      setState(() {
                        isPlaying = true;
                      });
                      audioplayer.onPositionChanged.listen(
                        (position) {
                          setState(() {
                            value = position.inSeconds.toDouble();
                          });
                        },
                      );
                    }
                    //await audioplayer.resume();
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((value % 60 < 10)
                        ? "${(value / 60).floor()} : 0${(value % 60).floor()}"
                        : "${(value / 60).floor()} : ${(value % 60).floor()}"),
                    Text((duration!.inSeconds % 60 < 10)
                        ? "${duration!.inMinutes} : 0${duration!.inSeconds % 60}"
                        : "${duration!.inMinutes} : ${duration!.inSeconds % 60}"),
                  ],
                ),
              ),

              //SizedBox(height: 10,),

              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: context.theme.buttonColor.withOpacity(0.8)),
                child: InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await audioplayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioplayer.resume();
                      setState(() {
                        isPlaying = true;
                      });
                      audioplayer.onPositionChanged.listen(
                        (position) {
                          setState(() {
                            value = position.inSeconds.toDouble();
                          });
                        },
                      );
                    }
                  },
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    color: Colors.white,
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
