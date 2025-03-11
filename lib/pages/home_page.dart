import 'package:flutter/material.dart';
import 'package:sensors/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: const AppDrawer(),
      body: Text("Demo app for various sensors found in phones"),
    );
  }
}
