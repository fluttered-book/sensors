import 'package:flutter/material.dart';
import 'package:sensors/pages/light_page.dart';
import 'package:sensors/pages/tilt_page.dart';

import '../../pages/home_page.dart';
import '../../sensors/chart/ui/sensors_chart_page.dart';
import '../../sensors/values/ui/sensors_plus_page.dart';

// https://docs.flutter.dev/cookbook/design/drawer

const menu = {
  'Home': HomePage.new,
  'Sensors': SensorsPlusPage.new,
  'Sensors Chart': SensorsChartPage.new,
  'Light': LightPage.new,
  'Tilt': TiltPage.new,
};

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.greenAccent,
                  Colors.blue,
                ],
              ),
            ),
            child: Text(
              'Demos',
              style: textTheme.titleLarge,
            ),
          ),
          ...menu.entries.map(
            (e) => ListTile(
              title: Text(e.key),
              onTap: () {
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => e.value.call(),
                    ),
                    (route) => route.isFirst);
              },
            ),
          )
        ],
      ),
    );
  }
}
