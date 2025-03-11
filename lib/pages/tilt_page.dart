import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class TiltPage extends StatelessWidget {
  const TiltPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  size: Offset(-20.0, -20.0),
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
