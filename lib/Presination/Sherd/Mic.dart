// import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:record/record.dart';

// class MyMic extends StatefulWidget {
//   const MyMic({super.key});

//   @override
//   State<MyMic> createState() => _MyMicState();
// }

// class _MyMicState extends State<MyMic> {
//   Duration duration = new Duration();
//   Duration position = new Duration();
//   bool isPlaying = false;
//   bool isLoading = false;
//   bool isPause = false;
//   final record = AudioRecorder();
//   String path = "";
//   String url = '';
//   late final AudioPlayer audioPlayer;

//   final player = AudioPlayer();
// //=============================
//   @override
//   Widget build(BuildContext context) {
//     return BubbleNormalAudio(
//       // key: data['uidmessage'],
//       color: Colors.blueAccent,
//       duration: duration.inSeconds.toDouble(),
//       position: position.inSeconds.toDouble(),
//       isPlaying: isPlaying,
//       isLoading: isLoading,
//       isPause: isPause,
//       onSeekChanged: (e) {},
//       onPlayPauseButtonClick: () {
//         if (!isPlaying) {
//           play(url);
//         } else {
//           stop_play();
//         }
//       },
//       sent: data['state'],
//     );
//     ;
//   }
// }
