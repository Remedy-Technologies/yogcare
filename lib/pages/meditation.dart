import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:velocity_x/velocity_x.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer= AudioPlayer()..setAsset('assets/audio/Senorita.mp3');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,

       appBar: AppBar(
        backgroundColor: Colors.transparent,
         title: "Meditation".text.xl2.color(context.primaryColor).make(),                                                        
      ),

      body: Container(),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key,required this.audioPlayer});

  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState=snapshot.data;
        final processingState=playerState?.processingState;
        final playing=playerState?.playing;
        if(!(playing ?? false)){
          return IconButton(
            onPressed: audioPlayer.play, 
            icon: Icon(Icons.play_arrow_rounded),
            color: Colors.blue,
            iconSize: 80,
          );
        }
        else if(processingState!=ProcessingState.completed)
        {
          return IconButton(
            onPressed: audioPlayer.play, 
            icon: Icon(Icons.pause_circle_rounded),
            color: Colors.blue,
            iconSize: 80,
          );
        }
        return Icon(
            Icons.play_arrow_rounded,
            color: Colors.blue,
            size: 80,
          );
      },
    );
  }
}