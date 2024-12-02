import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircularIndicator {
  CircularIndicator._();

  static const waveSpinkit = SpinKitWave(
    color: Colors.black,
    size: 20.0,
  );

  static const squareCircle = SpinKitSquareCircle(
    color: Colors.black,
    size: 20.0,
  );

  static const waveSpinkitButton = SpinKitWave(
    color: Colors.white,
    size: 15.0,
  );
}
