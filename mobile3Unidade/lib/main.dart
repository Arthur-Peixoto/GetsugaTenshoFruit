import 'package:flutter/material.dart';
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
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Center(child: Image.asset(""));
  }
}