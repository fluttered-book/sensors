import 'package:flutter/material.dart';

typedef P3 = ({double x, double y, double z});

class SensorSliders extends StatelessWidget {
  final Stream<P3> stream;
  final double min;
  final double max;

  const SensorSliders(
      {required this.stream, required this.min, required this.max, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: Text("No data"));
        final point = snapshot.data!;
        return Column(
          children: [
            Slider(
              activeColor: Colors.red,
              value: point.x.clamp(min, max),
              min: min,
              max: max,
              onChanged: (_) {},
            ),
            Text("x: ${point.x}"),
            Slider(
              activeColor: Colors.green,
              value: point.y.clamp(min, max),
              min: min,
              max: max,
              onChanged: (_) {},
            ),
            Text("y: ${point.y}"),
            Slider(
              activeColor: Colors.blue,
              value: point.z.clamp(min, max),
              min: min,
              max: max,
              onChanged: (_) {},
            ),
            Text("z: ${point.z}"),
          ],
        );
      },
    );
  }
}
