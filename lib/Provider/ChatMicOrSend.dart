import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class Chatmicorsend extends ChangeNotifier {
  bool _statelength = false;
  bool _statemic = false;

  bool get state => _statelength;
  bool get stateMic => _statemic;
  checLength(int len) {
    if (len > 0) {
      _statelength = true;
    } else {
      _statelength = false;
    }

    notifyListeners();
  }

  checTapMic(bool state) {
    if (state) {
      _statemic = state;
      notifyListeners();
    } else {
      _statemic = state;
      notifyListeners();
    }
  }

  late AudioPlayer audioPlayer;
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  bool init = false;
  final record = AudioRecorder();
  String path = "";
  String url = '';

  play({required String url}) async {
    await audioPlayer.play(UrlSource(url));
    isPlaying = true;
    notifyListeners();
  }

  stop_play() async {
    await audioPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  start_Record() async {
    final location = await getApplicationDocumentsDirectory();
    String name = Uuid().v1();
    print("start record");
    if (await record.hasPermission()) {
      await record.start(RecordConfig(), path: location.path + name + ".m4a");
    }
  }

  stop_Record() async {
    final String? final_path = await record.stop();

    path = final_path!;
    notifyListeners();
    print("stopRecoed");
    await uploadRecord();
  }

  uploadRecord() async {
    String name = basename(path);
    final ref = FirebaseStorage.instance.ref('voies/' + name);
    await ref.putFile(File(path));
    String download_url = await ref.getDownloadURL();

    url = download_url;
    notifyListeners();
    print('uploded');
  }

  initializePlayer({required AudioPlayer audioPlayer}) {
    if (audioPlayer == null) audioPlayer = audioPlayer;
  }
}
