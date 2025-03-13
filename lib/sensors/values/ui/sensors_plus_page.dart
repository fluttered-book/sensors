import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../common/widgets/app_drawer.dart';
import '../../../common/widgets/header.dart';
import 'sensor_sliders.dart';

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
          SensorSliders(
            stream: accelerometerEventStream()
                .map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            min: -50,
            max: 50,
          ),
          Divider(),
          Header("User Accelerometer m/s2"),
          SensorSliders(
            stream: userAccelerometerEventStream().map<P3>((e) => (
                  x: e.x,
                  y: e.y,
                  z: e.z,
                )),
            min: -50,
            max: 50,
          ),
          Divider(),
          Header("Gyroscope"),
          SensorSliders(
            stream:
                gyroscopeEventStream().map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            min: -50,
            max: 50,
          ),
          Divider(),
          Header('Magnetometer (μT)'),
          SensorSliders(
            stream: magnetometerEventStream()
                .map<P3>((e) => (x: e.x, y: e.y, z: e.z)),
            min: -50,
            max: 50,
          ),
          Divider(),
          Header('Barometer'),
          StreamBuilder(
            stream: barometerEventStream(),
            builder: (context, snapshot) =>
                snapshot.hasData && snapshot.data?.pressure != null
                    ? Column(
                        children: [
                          Slider(
                            min: 0,
                            max: 2000,
                            value: snapshot.data!.pressure,
                            onChanged: (_) {},
                          ),
                          Text(snapshot.data!.pressure.toString())
                        ],
                      )
                    : Center(child: Text("No data")),
          ),
        ],
      ),
    );
  }
}
