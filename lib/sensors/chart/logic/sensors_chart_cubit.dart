import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'sensors_chart_state.dart';

class SensorsChartCubit extends Cubit<SensorsChartState> {
  late StreamSubscription<DataPoint> _subscription;

  SensorsChartCubit({
    required Stream<DataPoint> stream,
    int maxDataPoints = 100,
  }) : super(SensorsChartState([])) {
    _subscription = stream.listen((event) {
      if (state.data.length >= maxDataPoints) {
        emit(SensorsChartState([
          ...state.data.skip(state.data.length % (maxDataPoints - 1)),
          event
        ]));
      } else {
        emit(SensorsChartState([...state.data, event]));
      }
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
