// ignore_for_file: non_constant_identifier_names

import 'package:chatapp/error/Error.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseLoginDataSource {
  Future login({required String email, required String password});
}

class RemoteLoginDataSource extends BaseLoginDataSource {
  @override
  Future login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ErrorFirebase(error: e.code.toString());
    }
  }
}
