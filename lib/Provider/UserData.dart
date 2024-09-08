import 'package:chatapp/Data/models/RegisterModel.dart';
import 'package:chatapp/Firebase/MethedFirebaseAuth.dart';
import 'package:flutter/material.dart';



 class UserProvider with ChangeNotifier {
  Registermodel? _userData;
  Registermodel? get getUser => _userData;
  
  refreshUser() async {
    Registermodel userData = await Methedfirebaseauth. getUserDetails();
    _userData = userData;
    notifyListeners();
  }
 }