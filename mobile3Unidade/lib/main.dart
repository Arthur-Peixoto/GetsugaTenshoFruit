import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fruit_ninja/flight-path-widget.dart';
import 'package:fruit_ninja/model.dart';

void main() {
  runApp(const GetsugaTenshoNinjaApp());
}

class GetsugaTenshoNinjaApp extends StatelessWidget {
  const GetsugaTenshoNinjaApp({super.key});
   // Define your desired value
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          color: Colors.grey.shade800,
          child: LayoutBuilder(builder: (context, constraints){
            Size screenSize = Size(constraints.maxWidth, constraints.maxHeight);
            Size worldSize = Size(WORLD_HEIGHT * screenSize.aspectRatio, WORLD_HEIGHT);
            return GetsugaTenshoNinja(
              screenSize: Size(constraints.maxWidth, constraints.maxHeight),
              worldSize: worldSize,
            );
          })
         ),
      ),
    );
  }
}

class GetsugaTenshoNinja extends StatefulWidget {
  final Size screenSize;
  final Size worldSize;

  const GetsugaTenshoNinja({Key ? key, required this.screenSize, required this.worldSize}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GetsugaTenshoNinjaState();
}

class GetsugaTenshoNinjaState extends State<GetsugaTenshoNinja> {

  Random r = new Random();
  List<PieceOfFruit> fruit =[];

  @override
  void initState(){
    super.initState();
  
    Timer.periodic(Duration(seconds: 2), (Timer timer){
      setState(() {
        fruit.add(PieceOfFruit(
        createdMS :DateTime.now().millisecondsSinceEpoch,
        flightPath: FlightPath(
          angle: 1.0,
          angularVelocity: .3 + r.nextDouble() * 3.0,
          position: Offset(2.0 * r.nextDouble() * (widget.worldSize.width - 4.0), 1.0),
          velocity: Offset(2.0 * r.nextDouble() * 2.0, 7.0 + r.nextDouble() * 7.0)),
        type:FruitType.values[r.nextInt(FruitType.values.length)]));
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    double pixelsPerUnit = widget.screenSize.width / widget.worldSize.width;
    List<Widget> stackItems = [];

    for (PieceOfFruit p in fruit){ 
      stackItems.add(FlightPathWidget(
       key: p.key,
       flightPath: p.flightPath,
       child: p.type.getImageWidget(pixelsPerUnit),
       worldSize: p.type.worldSize,
       pixelsPerUnit: pixelsPerUnit,
       onOffScreen:() {
        setState(() {
          fruit.remove(p);
        });
       },
          ));
    }
    return Stack(
      children: stackItems,
    );
  }
}