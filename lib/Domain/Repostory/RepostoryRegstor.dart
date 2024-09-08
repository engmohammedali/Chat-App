import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class RepostoryregstorDomain extends Equatable {
  Future baseRepostoryregstor({
    required String email,
    required String password,
    required String username,
    required Uint8List imgPath,
    required String imgName,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
