import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key, required String title}) : super(key: key);

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  late int sec = 10;
  late AudioPlayer player;
  late AudioCache cache;
  bool isPlay = false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();
  int index=0;
  late Color full=Colors.indigo;

  List<String> mylist= ['a.mp3','b.mp3','c.mp3', 'd.mp3', 'e.mp3'];
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    cache = AudioCache(fixedPlayer: player);
    cache.load("a.mp3");
    index=0;
    setUp();
  }

  setUp() {
    player.onAudioPositionChanged.listen((c) {
      setState(() {
        currentPostion = c;
      });
      player.onDurationChanged.listen((l) {
        musicLength = l;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: size.height / 2,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.indigo),
          child: const Text(
            "تشغيل الموسيقى",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${currentPostion.inSeconds}"),
              Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * .7,
                  child: Slider(
                      value: currentPostion.inSeconds.toDouble(),
                      max: musicLength.inSeconds.toDouble(),
                      onChanged: (val) {
                        seekTo(val.toInt());

                      })),
              Text("${musicLength.inSeconds}",style: TextStyle(color: full),),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 7,
            ),
            IconButton(
              onPressed: () {
                if (currentPostion.inSeconds == 0 ||
                    currentPostion.inSeconds < sec) {
                  seekTo(0);
                  // isPlay = false;
                }
                else if (currentPostion.inSeconds > 10)
                {
                  seekTo(currentPostion.inSeconds - sec);
                }

              },
              icon: const Icon(FontAwesomeIcons.backward),
              iconSize: 20,
              color: Colors.indigo,
            ),
            SizedBox(
              width: size.width / 7,
            ),
            IconButton(
              onPressed: () {
                if (isPlay) {
                  setState(() {
                    isPlay = false;
                    stopMusic();
                  });
                } else {
                  setState(() {
                    isPlay = true;
                    //cache.play("a.mp3");
                    playMusic();
                  });
                  //playMusic();
                }
              },
              icon: isPlay
                  ? const Icon(FontAwesomeIcons.pause)
                  : const Icon(FontAwesomeIcons.play),
              iconSize: 20,
              color: Colors.indigo,
            ),
            SizedBox(
              width: size.width / 7,
            ),
            IconButton(
              onPressed: () {
                if (currentPostion < musicLength - Duration(seconds: 10)) {
                  seekTo(currentPostion.inSeconds + sec);
                }
                else {
                  seekTo(musicLength.inSeconds);
                  setState(() {
                    isPlay=false;
                  });
                  player.stop();
                }

                // setState(() {
                //   seekTo(musicLength.inSeconds+sec);
                //   if (currentPostion < musicLength - Duration(seconds: 10)) {
                //     seekTo(currentPostion.inSeconds+10);
                //     print (currentPostion);
                //     print (musicLength);
                //   }
                //   else{
                //     seekTo(musicLength.inSeconds);
                //   isPlay=false;
                //   player.stop();
                //     print ("$currentPostion   +else");
                //     print ("$musicLength    +else");
                //   }
                // });
              },
              icon: const Icon(FontAwesomeIcons.forward),
              iconSize: 20,
              color: Colors.indigo,
            ),
            SizedBox(
              width: size.width / 7,
            ),
          ],
        ),
      ],
    ));
  }

  void stopMusic() {
    player.pause();
  }

  void playMusic() {
    cache.play("a.mp3");
  }

  void seekTo(int i) {
    player.seek(
      Duration(seconds: i),
    );
  }
}
