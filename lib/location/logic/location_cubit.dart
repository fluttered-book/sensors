import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  StreamSubscription<Position>? _subscription;

  LocationCubit() : super(LocationUnknown());

  Future<void> _ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw LocationDisabled();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw LocationDenied();
      }
    }
  }

  void requestPosition() async {
    try {
      await _ensurePermission();
      final position = await Geolocator.getCurrentPosition();
      emit(LocationPosition(position));
    } on LocationError catch (e) {
      emit(e);
    }
  }

  void streamPosition() async {
    try {
      await _ensurePermission();
      final lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        emit(LocationPosition(lastPosition));
      }
      _subscription = Geolocator.getPositionStream().listen((position) {
        emit(LocationPosition(position));
      });
    } on LocationError catch (e) {
      emit(e);
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
