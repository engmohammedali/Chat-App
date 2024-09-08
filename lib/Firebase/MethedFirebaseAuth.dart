import 'dart:typed_data';

import 'package:chatapp/Data/models/RegisterModel.dart';
import 'package:chatapp/Firebase/getImgURL.dart';
import 'package:chatapp/error/Error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Methedfirebaseauth {
  // functoin to get user details from Firestore (Database)
  static Future<Registermodel> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return Registermodel.convertSnap2Model(snap);
  }

  static Future<void> createChat(
      {required String uidChat,
      required String usernametoSend,
      required String uidSender,
      required String uidtoSend,
      required String imgPortofileSend,
      required DateTime time,
      required String emailtoSend}) async {
    try {
      await FirebaseFirestore.instance.collection('chat').doc(uidChat).set({
        'uidSender': uidSender,
        'usernametoSend': usernametoSend,
        'uidtoSend': uidtoSend,
        'uidChat': uidChat,
        "imgPortofileSend": imgPortofileSend,
        'time': time,
        'emailtoSend': emailtoSend
      });
    } on FirebaseAuthException catch (e) {
      throw ErrorFirebase(error: e.code.toString());
    }
  }

  static Future<void> chatWhitUser(
      {required String uidChat,
      required String uidmessage,
      required String uid,
      required String uidSender,
      required DateTime time,
      required String message,
      required String type}) async {
    try {
      await FirebaseFirestore.instance
          .collection('chat')
          .doc(uidChat)
          .collection("messages")
          .add({
        'uid': uid,
        'uidmessage': uidmessage,
        'uidSender': uidSender,
        'message': message,
        'time': time,
        'type': type,
        'state': false
      });
    } on FirebaseAuthException catch (e) {
      throw ErrorFirebase(error: e.code.toString());
    }
  }

  static Future<void> UpdateUser(
      {required String uid,
      required String username,
      required String email,
      required String password,
      required String imgPorfile}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "email": email,
      "password": password,
      "uid": uid,
      "username": username,
      "imgProfile": imgPorfile,
    });
  }

  static Future<void> UpdateUserWhitImg({
    required String uid,
    required String username,
    required String email,
    required String password,
    required Uint8List imgPath,
    required String imgName,
  }) async {
    String imgPorfile = await getImgURL(imgName: imgName, imgPath: imgPath);
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "email": email,
      "password": password,
      "uid": uid,
      "username": username,
      "imgProfile": imgPorfile,
    });
  }

  static readMessage(
      {required String uidChat,
      required String uid,
      required bool state}) async {
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(uidChat)
        .collection("messages")
        .where('state', isEqualTo: false)
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.update({'state': state});
      }
    });
  }
}
