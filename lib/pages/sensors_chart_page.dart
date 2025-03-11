import 'package:flutter/material.dart';
import 'package:sensors/widgets/header.dart';
import 'package:sensors/widgets/sensor_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsChartPage extends StatelessWidget {
  const SensorsChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Senors Chart")),
      body: ListView(children: [
        Header("Accelerometer m/s2"),
        SizedBox(
          height: 200,
          child: SensorStreamChart(
            key: Key('accelerometer'),
            stream: accelerometerEventStream().map(
              (e) => (
                x: e.x,
                y: e.y,
                z: e.z,
                timestamp: e.timestamp.millisecondsSinceEpoch
              ),
            ),
          ),
        ),
        Divider(),
        Header("User Accelerometer m/s2"),
        SizedBox(
          height: 200,
          child: SensorStreamChart(
            key: Key('user-accelerometer'),
            stream: userAccelerometerEventStream().map((e) => (
                  x: e.x,
                  y: e.y,
                  z: e.z,
                  timestamp: e.timestamp.millisecondsSinceEpoch
                )),
          ),
        ),
        Divider(),
        Header("Gyroscope"),
        SizedBox(
          height: 200,
          child: SensorStreamChart(
            key: Key('gyroscope'),
            stream: gyroscopeEventStream().map(
              (e) => (
                x: e.x,
                y: e.y,
                z: e.z,
                timestamp: e.timestamp.millisecondsSinceEpoch
              ),
            ),
          ),
        ),
        Divider(),
        Header('Magnetometer (μT)'),
        SizedBox(
          height: 200,
          child: SensorStreamChart(
            key: Key('magnetometer'),
            stream: magnetometerEventStream().map(
              (e) => (
                x: e.x,
                y: e.y,
                z: e.z,
                timestamp: e.timestamp.millisecondsSinceEpoch
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
