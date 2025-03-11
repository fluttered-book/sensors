import 'package:flutter/material.dart';

typedef P3 = ({double x, double y, double z});

class SensorSlider extends StatelessWidget {
  final P3? point;
  final double min;
  final double max;

  const SensorSlider(this.point,
      {required this.min, required this.max, super.key});

  @override
  Widget build(BuildContext context) {
    return point != null
        ? Column(
            children: [
              Slider(
                secondaryActiveColor: Colors.red,
                value: point!.x.clamp(min, max),
                min: min,
                max: max,
                onChanged: (_) {},
              ),
              Slider(
                secondaryActiveColor: Colors.green,
                value: point!.y.clamp(min, max),
                min: min,
                max: max,
                onChanged: (_) {},
              ),
              Slider(
                secondaryActiveColor: Colors.blue,
                value: point!.z.clamp(min, max),
                min: min,
                max: max,
                onChanged: (_) {},
              ),
            ],
          )
        : Center(child: Text("No data"));
  }
}
