import 'dart:async';

import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

typedef DataPoint = ({double x, double y, double z, int timestamp});

class SensorState {
  final List<DataPoint> data;
  const SensorState(this.data);
  int get startMillis => (data.isNotEmpty
      ? data.first.timestamp
      : DateTime.now().millisecondsSinceEpoch);
  int get endMillis => (data.isNotEmpty
      ? data.last.timestamp
      : DateTime.now().millisecondsSinceEpoch);
}

class SensorCubit extends Cubit<SensorState> {
  late StreamSubscription<DataPoint> _subscription;

  SensorCubit({required Stream<DataPoint> stream, int maxDataPoints = 100})
      : super(SensorState([])) {
    _subscription = stream.listen((event) {
      if (state.data.length >= maxDataPoints) {
        emit(SensorState([
          ...state.data.skip(state.data.length % (maxDataPoints - 1)),
          event
        ]));
      } else {
        emit(SensorState([...state.data, event]));
      }
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

class SensorStreamChart extends StatelessWidget {
  final Stream<DataPoint> stream;
  const SensorStreamChart({required this.stream, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SensorCubit>(
      create: (_) => SensorCubit(stream: stream),
      child: BlocBuilder<SensorCubit, SensorState>(builder: (context, state) {
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
