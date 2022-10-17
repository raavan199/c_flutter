import 'package:flutter/material.dart';

class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(131, 0, 0, 0),
    offset: Offset(0, 2),
    blurRadius: 5,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    offset: Offset(0, -6),
    blurRadius: 10,
  );
  static const BoxShadow blueShadow = BoxShadow(
    color: Color.fromARGB(30, 87, 85, 85),
    spreadRadius: 1,
    blurRadius: 6,
    offset: Offset(0, 6),
  );

  static const BoxShadow greyShadow = BoxShadow(
    color: Color.fromARGB(30, 158, 157, 157),
    spreadRadius: 1,
    blurRadius: 4,
    offset: Offset(0, 4),
  );

  static const BoxShadow yellowShadow = BoxShadow(
    color: Color.fromARGB(25, 255, 191, 103),
    spreadRadius: 1,
    blurRadius: 6,
    offset: Offset(0, 6),
  );


  static const BoxShadow boxShadow = BoxShadow(
    color: Color.fromARGB(60, 0, 0, 0),
    spreadRadius: 2,
    blurRadius: 6,
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromARGB(50, 0, 0, 0),
    spreadRadius: 1,
    blurRadius: 3,
  );
  static const BoxShadow freeProduct = BoxShadow(
    color: Color.fromARGB(50, 0, 0, 0),
    spreadRadius: 1,
    blurRadius: 3,
  );
}
