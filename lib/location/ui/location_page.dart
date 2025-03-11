import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/app_drawer.dart';
import '../logic/location_cubit.dart';
import '../logic/location_state.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _CoordinatesPageState();
}

class _CoordinatesPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location")),
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (_) => LocationCubit()..requestPosition(),
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) => Center(
            child: switch (state) {
              LocationUnknown() => CircularProgressIndicator(),
              LocationDisabled() => Text("Location disabled"),
              LocationDenied() => Text("Location denied"),
              LocationPosition() => Text(state.position.toString()),
            },
          ),
        ),
      ),
    );
  }
}
