// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class EventsAuth extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsRegisterGo extends EventsAuth {
  String email;
  String password;
  String username;

  Uint8List imgPath;
  String imgName;

  EventsRegisterGo({
    required this.email,
    required this.password,
    required this.username,
    required this.imgPath,
    required this.imgName,
  });
  @override
  List<Object?> get props => [
        email,
        password,
        username,
        imgPath,
        imgName,
      ];
}
