import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

import '../common/widgets/app_drawer.dart';

class TiltPage extends StatelessWidget {
  const TiltPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tilt"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Tilt(
          childLayout: ChildLayout(
            outer: [
              Positioned(
                child: TiltParallax(
                  size: Offset(-10.0, -10.0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: FlutterLogo(),
                  ),
                ),
              ),
              Positioned(
                child: TiltParallax(
                  size: Offset(-50.0, -50.0),
                  child: FilledButton(onPressed: () {}, child: Text("Go!")),
                ),
              ),
            ],
          ),
          child: Image(
            image: AssetImage("assets/hills_day.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
