import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fruit_ninja/model.dart';

class FlightPathWidget extends StatefulWidget {

  final FlightPath flightPath;

  final Size worldSize;
  final double pixelsPerUnit;

  final Widget child;

  final void Function() onOffScreen;

  const FlightPathWidget({Key ? key, required this.flightPath ,required this.child, required this.worldSize, required this.pixelsPerUnit, required this.onOffScreen});
  
  @override
  State<StatefulWidget> createState() => FlightPathWidgetState();
}

class FlightPathWidgetState extends State<FlightPathWidget> with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState(){
    super.initState();

    List<double> zeros = widget.flightPath.zeros;
    double time = max(zeros[0], zeros[1]);

    time += 1.0;

    controller = AnimationController(vsync: this,
    duration: Duration(milliseconds: (time * 1000.0).round()), 
    upperBound: time);

    controller.addStatusListener((status) {if (status == AnimationStatus.completed){
      widget.onOffScreen();
    }});

    controller.forward();
  }

  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(animation: controller, builder: (context, child){
        Offset position = widget.flightPath.getPosition(controller.value) * widget.pixelsPerUnit;
        return Positioned(
        left: position.dx - widget.worldSize.width * .5, 
        bottom: position.dy - widget.worldSize.width * .5,
        child: Transform(
          transform: Matrix4.rotationZ(widget.flightPath.getAngle(controller.value)),
          alignment: Alignment.center,
          child: child,
        ),);
    },);
  }
}