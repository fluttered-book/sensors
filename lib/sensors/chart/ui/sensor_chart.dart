import 'dart:async';

import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/sensors_chart_cubit.dart';
import '../logic/sensors_chart_state.dart';

class SensorChart extends StatelessWidget {
  final Stream<DataPoint> stream;
  const SensorChart({required this.stream, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SensorsChartCubit>(
      create: (_) => SensorsChartCubit(stream: stream),
      child: BlocBuilder<SensorsChartCubit, SensorsChartState>(
          builder: (context, state) {
        final data = state.data;
        final end = state.endMillis;
        return LineChart(
          [
            Series<DataPoint, int>(
              id: "$key-series-x",
              data: data,
              domainFn: (d, _) => (d.timestamp - end),
              measureFn: (d, _) => d.x,
            ),
            Series<DataPoint, int>(
              id: "$key-series-y",
              data: data,
              domainFn: (d, _) => (d.timestamp - end),
              measureFn: (d, _) => d.y,
            ),
            Series<DataPoint, int>(
              id: "$key-series-z",
              data: data,
              domainFn: (d, _) => (d.timestamp - end),
              measureFn: (d, _) => d.z,
            )
          ],
          animate: false,
        );
      }),
    );
  }
}
