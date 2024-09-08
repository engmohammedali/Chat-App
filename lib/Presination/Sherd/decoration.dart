import 'package:flutter/material.dart';

InputDecoration decoration =    InputDecoration(
  hintText: "Enter your email",
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.orange),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.blue),
      borderRadius: BorderRadius.all(Radius.circular(10))),
);
