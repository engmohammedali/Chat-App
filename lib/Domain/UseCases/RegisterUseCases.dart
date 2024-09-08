import 'dart:typed_data';

import 'package:chatapp/Domain/Repostory/RepostoryRegstor.dart';

class Registerusecases {
  final RepostoryregstorDomain repostoryregstor;
  Registerusecases({required this.repostoryregstor});

  Future<void> call({
    required String email,
    required String password,
    required String username,
    required Uint8List imgPath,
    required String imgName,
  }) async {
    await repostoryregstor.baseRepostoryregstor(
        email: email,
        password: password,
        username: username,
        imgPath: imgPath,
        imgName: imgName);
  }
}
