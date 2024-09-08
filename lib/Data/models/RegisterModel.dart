import 'package:chatapp/Domain/Eitnites/RegisaterData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registermodel extends Regisaterdata {
  String? imgProfile;
  String uid;

  Registermodel(
      {required super.email,
      required super.password,
      required super.username,
      required this.imgProfile,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "uid": uid,
      'imgProfile': imgProfile,
      "username": username,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Registermodel(
      email: snapshot['email'],
      password: snapshot['password'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      imgProfile: snapshot['imgProfile'],
    );
  }
}
