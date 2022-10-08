import 'package:flutter/material.dart';
// import 'package:music_player/my_home_page.dart';
import 'package:music_player/play_music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const PlayMusic(title: 'Flutter Demo Home Page'),
    );
  }
}
