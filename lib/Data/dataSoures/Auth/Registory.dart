// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:chatapp/Firebase/getImgURL.dart';
import 'package:chatapp/error/Error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseRegistorDataSource {
  // required Registermodel registermodel,

  Future registor({
    required String email,
    required String password,
    required String username,
    required Uint8List imgPath,
    required String imgName,
  });
}

class RemoteRegistorDataSource extends BaseRegistorDataSource {
  @override
  Future registor({
    required String email,
    required String password,
    required String username,
    required Uint8List imgPath,
    required String imgName,
    // required Registermodel registermodel,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      String imgProfile = await getImgURL(imgName: imgName, imgPath: imgPath);

      await users
          .doc(credential.user!.uid)
          .set({
            "email": email,
            "password": password,
            "uid": credential.user!.uid,
            "username": username,
            "imgProfile": imgProfile,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      throw ErrorFirebase(error: e.code.toString());
    }
  }
}
