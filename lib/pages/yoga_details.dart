// ignore_for_file: prefer_const_constructors
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/models/yoga_model.dart';

class YogaDetails extends StatefulWidget {
  final Yogas yogas;

  const YogaDetails({super.key, required this.yogas});

  @override
  State<YogaDetails> createState() => _YogaDetailsState();
}

class _YogaDetailsState extends State<YogaDetails> {
  final audioplayer = AudioPlayer();
  bool isPlaying = false;
  bool isShow = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
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
  }

  Future setAudio() async {
    //Repeat song when completed
    audioplayer.setReleaseMode(ReleaseMode.loop);
    // Load audio from Url
    String url = widget.yogas.music;
    //audioplayer.setSourceUrl(url);
    audioplayer.setSource(UrlSource(url));
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.cardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                      tag: Key(widget.yogas.id.toString()), //tag on both sides
                      child: Image.network(widget.yogas.img))
                  .p16()
                  .h32(context),
              Visibility(
                  visible: !isShow,
                  child: const CircularProgressIndicator(color: Colors.purple)),
              Visibility(
                visible: isShow,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioplayer.pause();
                    } else {
                      await audioplayer.resume();
                    }
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                        return const EdgeInsets.all(15);
                      }),
                      shape: MaterialStatePropertyAll(CircleBorder(
                          eccentricity: 0, side: BorderSide.none))),
                  child: Icon(isPlaying ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white, size: 35),
                ),
              ),
              Column(children: [
                VxArc(
                    height: 15.0,
                    edge: VxEdge.TOP,
                    arcType: VxArcType.CONVEY,
                    child: Container(
                      color: context.canvasColor,
                      width: context.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 46,
                          horizontal: 36,
                        ),
                        child: Column(children: [
                          widget.yogas.name.text.xl3
                              .textStyle(context.captionStyle)
                              .bold
                              .color(context.primaryColor)
                              .make(),

                          Text(
                            widget.yogas.desc,
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ).py8(),
                          //prod description
                          widget.yogas.longdesc.text.make().py8(),
                        ]),
                      ),
                    ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
