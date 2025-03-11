typedef DataPoint = ({double x, double y, double z, int timestamp});

class SensorsChartState {
  final List<DataPoint> data;
  const SensorsChartState(this.data);
  int get startMillis => (data.isNotEmpty
      ? data.first.timestamp
      : DateTime.now().millisecondsSinceEpoch);
  int get endMillis => (data.isNotEmpty
      ? data.last.timestamp
      : DateTime.now().millisecondsSinceEpoch);
}
