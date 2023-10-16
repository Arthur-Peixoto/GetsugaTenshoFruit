import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Offset GRAVITY = Offset(0, -9.8);
const double WORLD_HEIGHT = 16.0;

enum FruitType {
  apple,
  banana,
  mango, 
  watermelon
}

extension FruitTypeUtil on FruitType {
  Size get worldSize{
    switch (this){
      case FruitType.apple:
      return Size(2.04, 2.0);
      case FruitType.banana:
      return Size(3.19, 2.0);
      case FruitType.mango:
      return Size(3.16, 2.0);
      case FruitType.watermelon:
      return Size(2.6, 2.0);
    }
  }

  String get imageFile{
    switch (this){
      case FruitType.apple:
      return "";
      case FruitType.banana:
      return "";
      case FruitType.mango:
      return "";
      case FruitType.watermelon:
      return "";
    }
  }

  Widget getImageWidget(double pixelsPerUnit) => Image.asset(imageFile, width: worldSize.width * pixelsPerUnit, height: worldSize.height * pixelsPerUnit);
}

class PieceOfFruit{
  final Key key = UniqueKey();
  final int createdMS;
  final FlightPath flightPath;
  final FruitType type;

  PieceOfFruit({required this.createdMS, required this.flightPath, required this.type});
}

class SlicedFruit{
  final Key key = UniqueKey(); 
  final List<Offset> slice;
  final FlightPath flightPath;
  final FruitType type;

  SlicedFruit({required this.slice, required this.flightPath, required this.type });
}

class Slice{
  final Key key = UniqueKey();
  final Offset begin;
  final Offset end;

  Slice({required this.begin, required this.end});
}

class FlightPath{
  final double angle;
  final double angularVelocity;
  final Offset position;
  final Offset velocity;

  FlightPath({required this.angle,required this.angularVelocity,required this.position,required this.velocity});

  Offset getPosition(double t){
    return (GRAVITY *.5) * t * t + velocity * t + position;
  }

  double getAngle(double t) => angle + angularVelocity * t;

  List<double> get zeros{
    double a = (GRAVITY * .5).dy;
    double sqrtTerm = sqrt(pow(velocity.dy, 2) - 4.0 * a * position.dy);
    return[
      (-velocity.dy + sqrtTerm) / (2 * a),
      (-velocity.dy - sqrtTerm) / (2 * a),
    ];
  }
}