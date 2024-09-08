import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String title;
  Color color;
  VoidCallback onPressed;
  MyButton({required this.title, required this.color, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          height: 18,
          minWidth: 200,
        ),
      ),
    );
  }
}
