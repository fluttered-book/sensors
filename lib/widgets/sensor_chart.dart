import 'dart:async';

import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';

typedef DataPoint = ({double x, double y, double z, DateTime timestamp});

class SensorStreamChart extends StatefulWidget {
  final Stream<DataPoint> stream;
  final int maxDataPoints;
  const SensorStreamChart(
      {super.key, required this.stream, this.maxDataPoints = 100});

  @override
  State<SensorStreamChart> createState() => _SensorStreamChartState();
}

class _SensorStreamChartState extends State<SensorStreamChart> {
  StreamSubscription<DataPoint>? _subscription;
  List<DataPoint> _data = [];
  late int _end;

  @override
  void initState() {
    _end = DateTime.now().millisecondsSinceEpoch;
    _subscription = widget.stream.listen((DataPoint event) {
      setState(() {
        if (_data.length >= widget.maxDataPoints) {
          _data = [
            ..._data.skip(_data.length % (widget.maxDataPoints - 1)),
            event
          ];
        } else {
          _data = [..._data, event];
        }
        _end = event.timestamp.millisecondsSinceEpoch;
        print(_data.length);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      [
        Series<DataPoint, int>(
          id: "${widget.key}-series-x",
          data: _data,
          domainFn: (d, _) => (d.timestamp.millisecondsSinceEpoch - _end),
          measureFn: (d, _) => d.x,
        ),
        Series<DataPoint, int>(
          id: "${widget.key}-series-y",
          data: _data,
          domainFn: (d, _) => (d.timestamp.millisecondsSinceEpoch - _end),
          measureFn: (d, _) => d.y,
        ),
        Series<DataPoint, int>(
          id: "${widget.key}-series-z",
          data: _data,
          domainFn: (d, _) => (d.timestamp.millisecondsSinceEpoch - _end),
          measureFn: (d, _) => d.z,
        )
      ],
      animate: false,
    );
  }
}
