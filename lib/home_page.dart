import 'package:flutter/material.dart';

import 'common/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Demo app for various sensors found in phones"),
      ),
    );
  }
}
