import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sensors/location/logic/location_state.dart';

import '../logic/location_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: BlocProvider(
        create: (_) => LocationCubit()..requestPosition(),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
                'Map with a live updating marker of your current location'),
          ),
          Flexible(
            child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
              if (state is! LocationPosition) {
                return CircularProgressIndicator();
              }
              final latLong =
                  LatLng(state.position.latitude, state.position.longitude);
              return FlutterMap(
                options: MapOptions(initialCenter: latLong),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  CurrentLocationLayer()
                ],
              );
            }),
          ),
        ]),
      ),
    );
  }
}
