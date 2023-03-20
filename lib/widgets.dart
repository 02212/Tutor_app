import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shared/colors.dart' as color;

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 45, 86, 119), width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 155, 155, 155), width: 2),
  ),
  errorBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 255, 60, 21), width: 2)),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 14),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      )));
}
