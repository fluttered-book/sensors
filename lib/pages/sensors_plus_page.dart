import 'package:flutter/material.dart';
import 'package:sensors/widgets/header.dart';
import 'package:sensors/widgets/sensor_sliders.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../widgets/app_drawer.dart';

class SensorsPlusPage extends StatelessWidget {
  const SensorsPlusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sensors Plus")),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          Header("Accelerometer m/s2"),
          StreamBuilder(
            stream: accelerometerEventStream()
                .map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            builder: (context, snapshot) =>
                SensorSlider(snapshot.data, min: -50, max: 50),
          ),
          Divider(),
          Header("User Accelerometer m/s2"),
          StreamBuilder(
            stream: userAccelerometerEventStream()
                .map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            builder: (context, snapshot) =>
                SensorSlider(snapshot.data, min: -50, max: 50),
          ),
          Divider(),
          Header("Gyroscope"),
          StreamBuilder(
            stream:
                gyroscopeEventStream().map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            builder: (context, snapshot) =>
                SensorSlider(snapshot.data, min: -50, max: 50),
          ),
          Divider(),
          Header('Magnetometer (μT)'),
          StreamBuilder(
            stream: magnetometerEventStream()
                .map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            builder: (context, snapshot) =>
                SensorSlider(snapshot.data, min: -50, max: 50),
          ),
          //Divider(),
          //Header('Barometer'),
          //StreamBuilder(
          //  stream: barometerEventStream(),
          //  builder: (context, snapshot) =>
          //      snapshot.hasData && snapshot.data?.pressure != null
          //          ? Column(
          //              children: [
          //                Slider(
          //                  value: snapshot.data!.pressure,
          //                  onChanged: (_) {},
          //                ),
          //                Text(snapshot.data!.timestamp.toIso8601String())
          //              ],
          //            )
          //          : Center(child: Text("No data")),
          //),
        ],
      ),
    );
  }
}
