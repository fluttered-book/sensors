import 'package:geolocator/geolocator.dart';

sealed class LocationState {}

final class LocationUnknown extends LocationState {}

sealed class LocationError extends LocationState {}

final class LocationDisabled extends LocationError {}

final class LocationDenied extends LocationError {}

final class LocationPosition extends LocationState {
  final Position position;
  LocationPosition(this.position);
}
